extends KinematicBody2D

const SPEED = 128
var motion = Vector2()
var mousePoint
var mouseAngle
var knockback = false
var knockbackDir = Vector2(0,0)

onready var cut = preload("res://assets/scenes/cut.tscn")

func _ready():
	set_process(true)
	pass

func _physics_process(delta):
	$CanvasLayer/playerHealth.value = globs.health[0]
	$CanvasLayer/priestHealth.value = globs.health[1]
	$CanvasLayer/Label.text = "Score: " + str(globs.score)
	
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
		
	if Input.is_action_just_pressed("ui_attack"):
		globs.playSound("res://assets/sounds/sfx/Sword_swing.ogg")
		var bodyList = $AttackArea.get_overlapping_bodies()
		var c = cut.instance()
		add_child(c)
		c.global_position = global_position
		c.angle = mouseAngle
		for b in bodyList:
			if b.is_in_group("enemy"):
				var a = rad2deg(global_position.angle_to_point(b.global_position))
				if abs(a-mouseAngle) < 45:
					b.damage(self)
					pass
		
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
		
	if Input.is_key_pressed(KEY_ESCAPE):
		$PauseMenu.show()
	
	if knockback:
		motion += knockbackDir * Vector2(SPEED * delta, SPEED * delta)
	move_and_slide(motion)
	
func damage(body):
	globs.health[0] -= 1
	var angle = global_position.angle_to_point(body.global_position)
	knockbackDir = Vector2(cos(angle), sin(angle))
	knockback = true
	$knockback.start()
	
func buff(k):
	if globs.health[0] + k > 10:
		globs.health[0] = 10
	else:
		globs.health[0] += k

func _on_knockback_timeout():
	knockback = false
