extends KinematicBody2D

const SPEED = 112
onready var player = get_tree().get_nodes_in_group("pc")[0]

var playerPoint
var playerAngle

var motion = Vector2()

func _ready():
	set_process(true)
	
func _process(delta):
	playerPoint = player.global_position
	playerAngle = rad2deg(global_position.angle_to_point(playerPoint))
	if playerAngle < -157.5 or playerAngle > 157.5:
		$Sprite.play("right")
		motion.x = SPEED
	elif playerAngle > 112.5 and playerAngle <= 157.5:
		$Sprite.play("upRight")
		motion.x = SPEED
		motion.y = -SPEED
	elif playerAngle > 67.5 and playerAngle <= 112.5:
		$Sprite.play("up")
		motion.y = -SPEED
	elif playerAngle > 22.5 and playerAngle <= 67.5:
		$Sprite.play("upLeft")
		motion.x = -SPEED
		motion.y = -SPEED
	elif playerAngle > -22.5 and playerAngle <= 22.5:
		$Sprite.play("left")
		motion.x = -SPEED
	elif playerAngle < -22.5 and playerAngle >= -67.5:
		$Sprite.play("downLeft")
		motion.x = -SPEED
		motion.y = SPEED
	elif playerAngle < -67.5 and playerAngle >= -112.5:
		$Sprite.play("down")
		motion.y = SPEED
	else:
		$Sprite.play("downRight")
		motion.x = SPEED
		motion.y = SPEED
		
	if global_position.distance_to(playerPoint) < 64:
		motion = Vector2(0,0)
	move_and_slide(motion)