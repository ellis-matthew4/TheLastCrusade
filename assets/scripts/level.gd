extends Node2D

export(Vector2) var START

signal Switch

func _ready():
	set_process(true)
	
func _process(delta):
	if globs.health[0] <= 0 or globs.health[1] <= 0:
		globs.path = "res://assets/scenes/LoseMenu.tscn"
		globs.lose = true
		emit_signal("Switch")
		
	if Input.is_key_pressed(KEY_K):
		switch()

func switch():
	get_tree().current_scene.level += 1
	if get_tree().current_scene.level <= 6:
		globs.path = "res://assets/levels/level" + str(get_tree().current_scene.level) + ".tscn"
	else:
		globs.path = "res://assets/scenes/WinMenu.tscn"
	emit_signal("Switch")