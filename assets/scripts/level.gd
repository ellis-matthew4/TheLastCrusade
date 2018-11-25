extends Node2D

export(Vector2) var START

signal Switch

func _ready():
	pass

func switch():
	emit_signal("Switch")