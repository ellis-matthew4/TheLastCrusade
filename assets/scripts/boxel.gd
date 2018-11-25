extends Node2D

export(bool) var Top = false
export(bool) var Right = false
export(bool) var Bottom = false
export(bool) var Left = false
export(int) var pathLength = 0
var active = false

func _ready():
	pass

func toString():
	print("This is a boxel!")