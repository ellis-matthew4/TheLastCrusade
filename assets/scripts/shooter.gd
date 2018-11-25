extends KinematicBody2D

var SPEED = 64
onready var player = get_tree().get_nodes_in_group("pc")[0]

var playerPoint
var playerAngle

var nav = null setget set_nav
var move_p = false
var to_move = Vector2()
var path = PoolVector2Array()
var initialposition = Vector2()
var knockback = false

export var health = 1

var motion = Vector2()
var knockbackDir = Vector2(0,0)

var aggro = false

var arrow = preload("res://assets/scenes/arrow.tscn")

func set_nav(new_nav):
	nav = new_nav
	update_path()
	
func update_path():
	path = nav.get_simple_path(position, player.position, true)
	if path.size() == 0:
		pass

func _ready():
	nav = get_tree().current_scene
	set_process(true)
	
func _process(delta):
	if health == 0:
		globs.health[0] += 1
		globs.bumpScore()
		queue_free()
	playerPoint = player.global_position
	playerAngle = rad2deg(global_position.angle_to_point(playerPoint))
	if (playerAngle < -157.5 or playerAngle > 157.5) or (playerAngle > -22.5 and playerAngle <= 22.5):
		$Sprite.play("left")
	elif (playerAngle > 112.5 and playerAngle <= 157.5) or (playerAngle > 22.5 and playerAngle <= 67.5):
		$Sprite.play("upLeft")
	elif playerAngle > 67.5 and playerAngle <= 112.5:
		$Sprite.play("up")
	elif playerAngle < -67.5 and playerAngle >= -112.5:
		$Sprite.play("down")
	else:
		$Sprite.play("downLeft")
		
	if !aggro:
		if global_position.distance_to(playerPoint) < 300:
			aggro = true
		
	if playerAngle < 90 or playerAngle > -90:
		$Sprite.flip_h = false
	if playerAngle > 90 or playerAngle < -90:
		$Sprite.flip_h = true
		
	if move_p:
		path = nav.get_simple_path(position, to_move+Vector2(randi()%100, randi()%100))
		initialposition = position
		move_p = false

	if position.distance_to(playerPoint) > 128:
		if path.size() > 0:
			move_towards(initialposition, path[0], delta)
	else:
		$Sprite.playing = false

func move_towards(pos, point, delta):
	$Sprite.playing = true
	var v = (point-pos).normalized()
	v *= SPEED
	move_and_slide(v)
	if position.distance_squared_to(point) < 9:
		path.remove(0)
		initialposition = position
			
func snap():
	var rx = int(position.x) % 16
	var ry = int(position.y) % 16
	if rx != 0:
		if rx > 8:
			position.x += 16-rx
		else:
			position.x -= rx
	if ry != 0:
		if ry > 8:
			position.y += 16-ry
		else:
			position.y -= ry

func _on_Timer_timeout():
	$AudioStreamPlayer2D.play()
	$Timer.start()
	if aggro:
		var a = arrow.instance()
		add_child(a)
	
func damage(body):
	health -= 1
	