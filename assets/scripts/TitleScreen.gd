extends CanvasLayer

signal Switch

func _ready():
	get_tree().current_scene.level = 1

func _on_Play_pressed():
	globs.initializeGame()
	globs.path = "res://assets/levels/level1.tscn"
	emit_signal("Switch")

func _on_Quit_pressed():
	get_tree().quit()