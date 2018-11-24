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

var boxels = []

func _ready():
	if BoxelSize == 1:
		position += Vector2(128,128)
		var b = Boxel.instance()
		b.Top = Top; b.Right = Right; b.Bottom = Bottom; b.Left = Left
		boxels.append(b)
	elif BoxelSize == 2:
		boxels.append([Boxel.instance(), Boxel.instance()])
		boxels.append([Boxel.instance(), Boxel.instance()])
		if Top:
			boxels[1][0].Top = true
			boxels[0][0].Top = true
		if Left:
			boxels[0][1].Left = true
			boxels[0][0].Left = true
		if Right:
			boxels[1][1].Right = true
			boxels[1][0].Right = true
		if Bottom:
			boxels[0][1].Bottom = true
			boxels[1][1].Bottom = true

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
