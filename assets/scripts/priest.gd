extends RigidBody2D

var SPEED = 112
onready var player = get_tree().get_nodes_in_group("pc")[0]

var playerPoint
var playerAngle

var nav = null setget set_nav
var path = []

var motion = Vector2()

func set_nav(new_nav):
	nav = new_nav
	update_path()
	
func update_path():
	path = nav.get_simple_path(position, player.position, true)
	if path.size() == 0:
		print("ERROR!")

func _ready():
	set_process(true)
	
func _process(delta):
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
		
	if playerAngle < 90 or playerAngle > -90:
		$Sprite.flip_h = false
	if playerAngle > 90 or playerAngle < -90:
		$Sprite.flip_h = true
		
	var walk_distance = SPEED * delta
	move_along_path(walk_distance)
	
func move_along_path(distance):
	if position.distance_to(player.position) > 32:
		$Sprite.playing = true
		var last_point = position
		for index in range(path.size()):
			var distance_between_points = last_point.distance_to(path[0])
			if distance <= distance_between_points and distance >= 0.0:
				motion = last_point.linear_interpolate(path[0], distance / distance_between_points)
				position = motion
				break
			elif distance < 0.0:
				position = path[0]
				break
			distance -= distance_between_points
			last_point = path[0]
			path.remove(0)
	else:
		$Sprite.playing = false
		if position.distance_to(player.position) > 64:
			snap()
			
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
	update_path()
	$Timer.start()
