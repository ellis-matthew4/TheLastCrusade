extends CanvasLayer

signal Switch

func _ready():
	pass

func _on_Play_pressed():
	globs.path = "res://assets/scenes/FloorBuilder.tscn"
	emit_signal("Switch")

func _on_Quit_pressed():
	get_tree().quit()