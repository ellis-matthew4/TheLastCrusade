extends TileMap

var Boxel = load("res://assets/scripts/boxel.gd")

export(Vector2) var BoxelPosition
export(int) var BoxelSize

var boxels = []
func initBoxels(size):
	BoxelSize = size
	for i in range(BoxelSize):
		var b = []
		for j in range(BoxelSize):
			b.append(Boxel.instance())
		boxels.append(b)


func _ready():
	pass

func rotate_clockwise():
	rotation_degrees += 90
	
	var old = [ Top, Right, Bottom, Left ]
	Top = old[3]
	Right = old[0]
	Bottom = old[1]
	Left = old[2]
	
func rotate_counterClockwise():
	rotation_degrees -= 90
	var old = [ Top, Right, Bottom, Left ]
	Top = old[1]
	Right = old[2]
	Bottom = old[3]
	Left = old[0]

#move on to the next floor!
func _advance(body):
	pass # replace with function body
