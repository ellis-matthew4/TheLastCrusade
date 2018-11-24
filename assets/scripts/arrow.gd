extends KinematicBody2D

const SPEED = 100
var angle
var direction
var motion = Vector2()

func _ready():
	var player = get_tree().get_nodes_in_group("pc")[0]
	angle = global_position.angle_to_point(player.global_position)
	direction = (player.global_position - global_position).normalized()
	rotation_degrees = rad2deg(angle)
	direction = Vector2(cos(angle), sin(angle)) * -1
	set_process(true)
	
func _process(delta):
	motion = direction * Vector2(SPEED, SPEED)
	move_and_slide(motion)

func _on_Timer_timeout():
	queue_free()

func _on_hitbox_body_entered(body):
	if body.is_in_group("pc") or body.is_in_group("priest"):
		body.damage(self)
		queue_free()

func damage(body):
	globs.bumpScore(5)
	queue_free()