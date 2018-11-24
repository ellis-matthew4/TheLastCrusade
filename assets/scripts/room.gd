extends Node2D

var Boxel = load("res://assets/scripts/boxel.gd")

export(Vector2) var BoxelPosition
export(int) var BoxelSize
export(int) var TileSize
export(bool) var Top
export(bool) var Right
export(bool) var Bottom
export(bool) var Left
var active = false

func _ready():
	pass

func rotate():
	rotation_degrees -= 90
	var old = [ Top, Right, Bottom, Left ]
	Top = old[1]
	Right = old[2]
	Bottom = old[3]
	Left = old[0]

#move on to the next floor!
func _advance(body):
	pass # replace with function body
	
func toString():
	print("This is a room!")
