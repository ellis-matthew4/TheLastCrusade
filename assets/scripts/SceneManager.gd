extends Node2D

#Below is code to preload the main menu of the game
var menu = preload("res://assets/scenes/testRoom.tscn")
var scene
var player = preload("res://assets/scenes/player.tscn")
var priest = preload("res://assets/scenes/priest.tscn")

#The default constructor of the scene manager, links the starting scene to the switch() method
func _ready():
	var p = player.instance()
	add_child(p)
	p.position = Vector2(64,64)
	var k = priest.instance()
	add_child(k)
	k.position = Vector2(32,32)
	scene = menu.instance()
	scene.connect("Switch", self, "switch")
	add_child(scene)
	pass
	
#The switch method changes the current scene to the one located in the Global Variables
func switch():
	var x = load(globs.path)
	remove_child(scene)
	scene = x.instance()
	scene.connect("Switch", self, "switch")
	add_child(scene)
	if get_tree().paused:
		get_tree().paused = false