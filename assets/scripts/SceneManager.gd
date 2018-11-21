extends Navigation2D

#Below is code to preload the main menu of the game
var menu = preload("res://assets/scenes/startRoom.tscn")
var scene
var player = preload("res://assets/scenes/player.tscn")
var priest = preload("res://assets/scenes/priest.tscn")
var stabber = preload("res://assets/scenes/shooter.tscn")

var p
var k

#The default constructor of the scene manager, links the starting scene to the switch() method
func _ready():
	p = player.instance()
	add_child(p)
	p.position = Vector2(64,64)
	k = priest.instance()
	add_child(k)
	k.position = Vector2(32,32)
	scene = menu.instance()
	k.nav = self
	var s = stabber.instance()
	add_child(s)
	s.position = Vector2(-64, -64)
	s.nav = self
	scene.connect("Switch", self, "switch")
	add_child(scene)
	scene.position += Vector2(128,128)
	pass
	
#The switch method changes the current scene to the one located in the Global Variables
func switch():
	var x = load(globs.path)
	remove_child(scene)
	scene = x.instance()
	p.position = x.START
	k.position = x.START - Vector2(32,-32)
	scene.connect("Switch", self, "switch")
	add_child(scene)
	if get_tree().paused:
		get_tree().paused = false