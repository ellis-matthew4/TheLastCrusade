extends Node2D

export(bool) var Top
export(bool) var Right
export(bool) var Bottom
export(bool) var Left
export(int) var pathLength
var active = false

func _ready():
	pass

func toString():
	print("This is a boxel!")