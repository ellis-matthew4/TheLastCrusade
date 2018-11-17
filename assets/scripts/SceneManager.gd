extends Node2D

#Below is code to preload the main menu of the game
#var menu = preload(globs.path)
var scene
var player = preload("res://assets/scenes/player.tscn")

#The default constructor of the scene manager, links the starting scene to the switch() method
func _ready():
	var p = player.instance()
	add_child(p)
	p.position = Vector2(100,100)
	#scene = menu.instance()
	#scene.connect("Switch", self, "switch")
	#dd_child(scene)
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