extends Area2D

const SPEED = 10
var angle setget set_angle
var direction

func _ready():
	set_process(true)
	
func _process(delta):
	global_position -= direction * Vector2(SPEED, SPEED)
	pass

func set_angle(angle):
	rotation_degrees = angle
	angle = deg2rad(angle)
	direction = Vector2(cos(angle), sin(angle))

func _on_Timer_timeout():
	queue_free()
