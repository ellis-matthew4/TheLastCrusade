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
	if (mouseAngle < -157.5 or mouseAngle > 157.5) or (mouseAngle > -22.5 and mouseAngle <= 22.5):
		$Sprite.play("left")
	elif (mouseAngle > 112.5 and mouseAngle <= 157.5) or (mouseAngle > 22.5 and mouseAngle <= 67.5):
		$Sprite.play("upLeft")
	elif mouseAngle > 67.5 and mouseAngle <= 112.5:
		$Sprite.play("up")
	elif mouseAngle < -67.5 and mouseAngle >= -112.5:
		$Sprite.play("down")
	else:
		$Sprite.play("downLeft")
		
	if mouseAngle < 90 or mouseAngle > -90:
		$Sprite.flip_h = false
	if mouseAngle > 90 or mouseAngle < -90:
		$Sprite.flip_h = true
		
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
		
	if motion != Vector2(0,0):
		$Sprite.playing = true
	else:
		$Sprite.playing = false
		
	move_and_slide(motion)