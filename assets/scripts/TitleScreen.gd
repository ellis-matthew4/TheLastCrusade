extends CanvasLayer

signal Switch

func _ready():
	globs.playMusic("res://assets/sounds/Hymns/Eye_of_God.ogg")
	get_tree().current_scene.level = 1

func _on_Play_pressed():
	globs.initializeGame()
	globs.playMusic("res://assets/sounds/Hymns/March_On.ogg")
	globs.path = "res://assets/levels/level1.tscn"
	emit_signal("Switch")

func _on_Quit_pressed():
	get_tree().quit()