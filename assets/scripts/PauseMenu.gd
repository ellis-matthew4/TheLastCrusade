extends CanvasLayer

func _ready():
	pass
	
func show():
	$Control.visible = true
	get_tree().paused = true
	
func hide():
	$Control.visible = false
	get_tree().paused = false

func _on_resume_pressed():
	$Control.visible = false
	hide()

func _on_quit_pressed():
	get_tree().quit()


