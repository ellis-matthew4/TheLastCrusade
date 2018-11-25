extends Node2D

onready var bar = $ProgressBar

func _ready():
	bar.max_value = get_parent().health
	bar.value = get_parent().health
	set_process(true)

func damage():
	bar.value -= 1