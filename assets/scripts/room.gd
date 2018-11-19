extends TileMap

export(Vector2) var BoxelPosition
export(Vector2) var BoxelSize
export(bool) var Top
export(bool) var Right
export(bool) var Bottom
export(bool) var Left

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