extends CanvasLayer

signal Switch

func _ready():
	pass
	
func show():
	get_tree().paused = true
	
func _on_resume_pressed():
	globs.path = "res://assets/scenes/TitleScreen.tscn"
	emit_signal("Switch")

func _on_quit_pressed():
	get_tree().quit()