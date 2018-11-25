extends Node2D

var Boxel = preload("res://assets/scenes/Boxel.tscn")

export(Vector2) var BoxelPosition
export(int) var BoxelSize
export(bool) var Top = false
export(bool) var Right = false
export(bool) var Bottom = false
export(bool) var Left = false
export var type = ""
var active = false
var TileSize = 16
var PixelSize = 16

var boxels = []

func _ready():
	assignBoxels()
	for list in boxels:
		for b in list:
			add_child(b)

func rotate():
	rotation_degrees -= 90
	var old = [ Top, Right, Bottom, Left ]
	Top = old[1]
	Right = old[2]
	Bottom = old[3]
	Left = old[0]
	assignBoxels()
	
func toString():
	print("This is a room!")
	
func assignBoxels():
	if BoxelSize == 1:
#		position += Vector2(128,128)
		boxels.append([Boxel.instance()])
		boxels[0][0].Top = Top
		boxels[0][0].Left = Left
		boxels[0][0].Right = Right
		boxels[0][0].Bottom = Bottom
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
			
func setTruePos():
	print("Setting true position of room " + type)
	print(BoxelPosition)
	position = Vector2((BoxelPosition.x * BoxelSize * TileSize * PixelSize) / 2, (BoxelPosition.y * BoxelSize * TileSize * PixelSize) / 2)
	print(position)

#move on to the next floor!
func _advance(body):
	pass # replace with function body
	