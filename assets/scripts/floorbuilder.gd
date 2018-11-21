extends Node

var start

var virtualRoom = load("res://assets/scripts/virtualRoom.gd")

var startRoom = load("res://assets/scenes/StartRoom.tscn")
var hallway2Opposite = load("res://assets/scenes/Hallway2Opposite.tscn")
var hallway2Adjacent = load("res://assets/scenes/Hallway2Adjacent.tscn")
var hallway3 = load("res://assets/scenes/Hallway3.tscn")
var hallway4 = load("res://assets/scenes/Hallway4.tscn")
var storeRoom = load("res://assets/scenes/StoreRoom.tscn")
var armory = load("res://assets/scenes/Armory.tscn")
var barracks = load("res://assets/scenes/Barracks.tscn")
var messHall = load("res://assets/scenes/MessHall.tscn")
var conferenceRoom = load("res://assets/scenes/ConferenceRoom.tscn")
var bossRoom = load("res://assets/scenes/BossRoom.tscn")
var stairsUp = load("res://assets/scenes/StartRoom.tscn")
var stairDown = load("res://assets/scenes/StartRoom.tscn")

var singleConnections = [barracks, storeRoom]
var specialRooms = [armory, barracks, storeRoom, messHall, conferenceRoom]
var hallways = [hallway2Adjacent, hallway2Opposite, hallway3, hallway4]
var rooms = []
var queue = []

var MIN_SIZE = 16
var MAX_SIZE = 32

# in terms of Boxels
var floorSize
var virualFloor = []

func setFloorSize():
	floorSize = randi()%(MAX_SIZE - MIN_SIZE) + MIN_SIZE
	for i in range(floorSize):
		var v = []
		for j in range(floorSize):
			v.append(virtualRoom.instance())
		virualFloor.append(v)

func markVRoom(k):
	for i to range(k.BoxelSize):
		for j to range(k.BoxelSize):
			virtualFloor[i, j].mark = true

func rotateRoom(k):
	if k.BoxelSize == 1:
    for c in k.get_children():
        c.position += Vector2(128, 128)
	k.rotate_clockwise()

func randRot():
	var rot = randi() % 4 + 1
	return rot

func randPos():
	var x = randi() % floorSize
	var y = randi() % floorSize
	return Vector2(x, y)

func addStartRoom():
	var s = startRoom.instance()
	s.BoxelPosition = randPos()
	for i in range(randRot()):
		rotateRoom(s)
	if (s.BoxelPosition.y == 0 and s.Top) or (s.BoxelPosition.y == (floorSize - 1) and s.Bottom):
		rotateRoom(s)
		rotateRoom(s)
	if (s.BoxelPosition.x == 0 and s.Left) or (s.BoxelPosition.x == (floorSize - 1) and s.Right):
		rotateRoom(s)
		rotateRoom(s)
	start = s
	
	rooms.append(start)

func genRooms():
	

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
