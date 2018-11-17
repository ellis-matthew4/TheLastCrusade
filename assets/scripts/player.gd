extends KinematicBody2D

const SPEED = 128
var motion = Vector2()
var mousePoint
var mouseAngle

func _ready():
	set_process(true)
	pass

func _physics_process(delta):
	mousePoint = get_global_mouse_position()
	mouseAngle = rad2deg(global_position.angle_to_point(mousePoint))
	if mouseAngle < -157.5 or mouseAngle > 157.5:
		$Sprite.play("right")
	elif mouseAngle > 112.5 and mouseAngle <= 157.5:
		$Sprite.play("upRight")
	elif mouseAngle > 67.5 and mouseAngle <= 112.5:
		$Sprite.play("up")
	elif mouseAngle > 22.5 and mouseAngle <= 67.5:
		$Sprite.play("upLeft")
	elif mouseAngle > -22.5 and mouseAngle <= 22.5:
		$Sprite.play("left")
	elif mouseAngle < -22.5 and mouseAngle >= -67.5:
		$Sprite.play("downLeft")
	elif mouseAngle < -67.5 and mouseAngle >= -112.5:
		$Sprite.play("down")
	else:
		$Sprite.play("downRight")
		
	if Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		motion.y = SPEED
	else:
		motion.y = 0
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	else:
		motion.x = 0
		
	move_and_slide(motion)