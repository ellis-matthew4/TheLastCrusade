extends Navigation2D

#Below is code to preload the main menu of the game
var menu = preload("res://assets/scenes/TitleScreen.tscn")
var scene
var player = preload("res://assets/scenes/player.tscn")
var priest = preload("res://assets/scenes/priest.tscn")

var level = 0

var p
var k

#The default constructor of the scene manager, links the starting scene to the switch() method
func _ready():
	scene = menu.instance()
	scene.connect("Switch", self, "switch")
	add_child(scene)
	pass
	
#The switch method changes the current scene to the one located in the Global Variables
func switch():
	if level == 0:
		p = player.instance()
		add_child(p)
		k = priest.instance()
		add_child(k)
		k.nav = self
	level += 1
	globs.path = "res://assets/levels/level" + str(level) + ".tscn"
	var x = load(globs.path)
	remove_child(scene)
	scene = x.instance()
	p.position = scene.START #Starting position, change later
	k.position = scene.START - Vector2(32,-32)
	scene.connect("Switch", self, "switch")
	add_child(scene)
	if get_tree().paused:
		get_tree().paused = false