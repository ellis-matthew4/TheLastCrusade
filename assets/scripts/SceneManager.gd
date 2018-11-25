extends Navigation2D

#Below is code to preload the main menu of the game
var menu = preload("res://assets/scenes/TitleScreen.tscn")
var scene
var player = preload("res://assets/scenes/player.tscn")
var priest = preload("res://assets/scenes/priest.tscn")

var level = 1

var p
var k

#The default constructor of the scene manager, links the starting scene to the switch() method
func _ready():
	scene = menu.instance()
	p = player.instance()
	k = priest.instance()
	scene.connect("Switch", self, "switch")
	add_child(scene)
	pass
	
#The switch method changes the current scene to the one located in the Global Variables
func switch():
	if level == 1:
		add_child(p)
		add_child(k)
		k.nav = self
	var x = load(globs.path)
	remove_child(scene)
	scene = x.instance()
	if level <= 6 and !globs.lose:
		p.position = scene.START #Starting position, change later
		k.position = scene.START - Vector2(16,-32)
	else:
		remove_child(p)
		remove_child(k)
	scene.connect("Switch", self, "switch")
	add_child(scene)
	if get_tree().paused:
		get_tree().paused = false