extends Node2D

var Boxel = load("res://assets/scripts/boxel.gd")

export(Vector2) var BoxelPosition
export(int) var BoxelSize
export(int) var TileSize

var boxels = []

func initBoxels(size):
	BoxelSize = size
	for i in range(BoxelSize):
		var b = []
		for j in range(BoxelSize):
			var box = Boxel.instance()
			box.active = true
			b.append(box)
		boxels.append(b)


func _ready():
	pass

func rotate():
	rotation_degrees -= 90
	# rotates the entire array of boxels
	for x in range(int(BoxelSize/2)):
		for y in range(x, BoxelSize-x-1):
			var temp = boxels[x][y]
			boxels[x][y] = boxels[y][BoxelSize-1-x]
			boxels[y][BoxelSize-1-x] = boxels[BoxelSize-1-x][BoxelSize-1-y]
			boxels[BoxelSize-1-y][x] = temp
	# rotates each boxel's set of connections
	for y in range(BoxelSize):
		for x in range(BoxelSize):
			var old = [boxels[x][y].Top, boxels[x][y].Right, boxels[x][y].Bottom, boxels[x][y].Left ]
			boxels[x][y].Top = old[1]
			boxels[x][y].Right = old[2]
			boxels[x][y].Bottom = old[3]
			boxels[x][y].Left = old[0]

#move on to the next floor!
func _advance(body):
	pass # replace with function body
