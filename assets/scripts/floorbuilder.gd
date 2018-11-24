extends Node

var start

var boxel = load("res://assets/scripts/boxel.gd")

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
var specialRooms = []
var types = [hallway2Adjacent, hallway2Opposite, hallway3, hallway4, armory, barracks, storeRoom, messHall, conferenceRoom]
var rooms = []
var queue = []

var MIN_SIZE = 16
var MAX_SIZE = 32

# in terms of Boxels
var floorSize
var virtualFloor = []

# sets a random floor size
func setFloorSize():
	floorSize = randi()%(MAX_SIZE - MIN_SIZE) + MIN_SIZE
	for i in range(floorSize):
		var v = []
		for j in range(floorSize):
			v.append(boxel.instance())
		virtualFloor.append(v)

# marks grid points on the virtual floor has taken
func markVRoom(k):
	for i in range(k.BoxelSize):
		for j in range(k.BoxelSize):
			virtualFloor[k.BoxelPosition.x + i][k.BoxelPosition.y + j] = k.boxels[i][j]

# rotates a room
func rotateRoom(k):
	if k.BoxelSize == 1:
    for c in k.get_children():
        c.position += Vector2(128, 128)
	k.rotate()

# creates random rotation
func randRot():
	var rot = randi() % 4 + 1
	return rot

# creates a random vector
func randPos():
	var x = randi() % floorSize
	var y = randi() % floorSize
	return Vector2(x, y)

# generates a floor
func genFloor():
	setFloorSize()
	addStartRoom()
	while(queue.size() > 0):
		if hasOpenConnection(queue[0]):
			var pos = getPos(queue[0])
			var temp
			if queue[0].pathLength >= 8:
				temp = stairsDown
			else:
				temp = types[randi() % types.size()]
			var possible
			if queue[0].Top:
				possible = possiblePositionsTop(queue[0], temp, temp.instance().BoxelSize)
			elif queue[0].Bottom:
				possible = possiblePositionsBottom(queue[0], temp, temp.instance().BoxelSize)
			elif queue[0].Right:
				possible = possiblePositionsRight(queue[0], temp, temp.instance().BoxelSize)
			elif queue[0].Left:
				possible = possiblePositionsLeft(queue[0], temp, temp.instance().BoxelSize)
			if possible.size() > 0:
				var r = possible[randi() % possible.size()]
				r.pathLength = queue[0].pathLength + 1
				markVRoom(r)
				addToQueue(r)
				rooms.append(r) 
		else:
			queue.pop()

# adds the start room to the virtual floor and the queue
func addStartRoom():
	var s = startRoom.instance()
	s.BoxelPosition = randPos()
	for i in range(randRot()):
		rotateRoom(s)
	while(not connectionsOpen(s)):
		rotateRoom(s)
	start = s
	start.pathLength = 1
	markVRoom(start)
	addToQueue(start)
	rooms.append(start)

# adds the boxel to the queue
func addToQueue(k):
	for y in range(k.BoxelSize):
		for x in range(k.BoxelSize):
			if k.boxels[y][x].Top or k.boxels[y][x].Bottom or k.boxels[y][x].Left or k.boxels[y][x].Right:
				queue.append(k.boxels[y][x])

# checks to see if room has any possible open connections
func hasOpenConnections(k):
	var pos = getPos(k)
	if k.Top and not virtualFloor.boxels[pos.y - 1][pos.x].active:
		return true
	if k.Bottom and not virtualFloor.boxels[pos.y + 1][pos.x].active:
		return true
	if k.Left and not virtualFloor.boxels[pos.y][pos.x - 1].active:
		return true
	if k.Right and not virtualFloor.boxels[pos.y][pos.x + 1].active:
		return true
	return false

# gets the position of the boxel in the virtualFloor
func getPos(k):
	for y in range(floorSize):
		for x in range(floorSize):
			if virtualFloor[y][x] == k:
				return Vector2(x, y)

# take in the current boxel, the room type, and the boxelsize
func possiblePositionsTop(k, l, BoxelSize):
	var possible = []
	for offset in range(BoxelSize):
		var temp = Vector2(k.BoxelPosition.x - offset, k.BoxelPosition.y - BoxelSize)
		var free = true
		if temp.x >= 0 and temp.y >= 0:
			for y in range(BoxelSize):
				for x in range(BoxelSize):
					if virtualFloor[temp.y + y][temp.x + x].active:
						free = false
			if free:
				var tRoom = l.instance()
				tRoom.BoxelPosition = temp
				for i in range(4):
					if connectionsOpen(tRoom):
						possible.append(tRoom)
					rotateRoom(tRoom)
	return possible
	
# take in the current boxel, the room type, and the boxelsize
func possiblePositionsBottom(k, l, BoxelSize):
	var possible = []
	for offset in range(BoxelSize):
		var temp = Vector2(k.BoxelPosition.x - offset, k.BoxelPosition.y + 1)
		var free = true
		if temp.x >= 0 and temp.y >= 0:
			for y in range(BoxelSize):
				for x in range(BoxelSize):
					if virtualFloor[temp.y + y][temp.x + x].active:
						free = false
			if free:
				var tRoom = l.instance()
				tRoom.BoxelPosition = temp
				for i in range(4):
					if connectionsOpen(tRoom):
						possible.append(tRoom)
					rotateRoom(tRoom)
	return possible
	
# take in the current boxel, the room type, and the boxelsize
func possiblePositionsLeft(k, l, BoxelSize):
	var possible = []
	for offset in range(BoxelSize):
		var temp = Vector2(k.BoxelPosition.x - BoxelSize, k.BoxelPosition.y - offset)
		var free = true
		if temp.x >= 0 and temp.y >= 0:
			for y in range(BoxelSize):
				for x in range(BoxelSize):
					if virtualFloor[temp.y + y][temp.x + x].active:
						free = false
			if free:
				var tRoom = l.instance()
				tRoom.BoxelPosition = temp
				for i in range(4):
					if connectionsOpen(tRoom):
						possible.append(tRoom)
					rotateRoom(tRoom)
	return possible
	
# take in the current boxel, the room type, and the boxelsize
func possiblePositionsRight(k, l, BoxelSize):
	var possible = []
	for offset in range(BoxelSize):
		var temp = Vector2(k.BoxelPosition.x + 1, k.BoxelPosition.y - offset)
		var free = true
		if temp.x >= 0 and temp.y >= 0:
			for y in range(BoxelSize):
				for x in range(BoxelSize):
					if virtualFloor[temp.y + y][temp.x + x].active:
						free = false
			if free:
				var tRoom = l.instance()
				tRoom.BoxelPosition = temp
				for i in range(4):
					if connectionsOpen(tRoom):
						possible.append(tRoom)
					rotateRoom(tRoom)
	return possible


# Checks to see if the room's open connections lead to a valid location
func connectionsOpen(k):
	for y in range(k.BoxelSize):
		for x in range(k.BoxelSize):
			# check only the outer perimeter of the room
			if (y == 0 or y == (k.BoxelSize - 1)) or (x == 0 or x == (k.BoxelSize - 1)):
				# check the top of the room
				if k.boxels[y][x].Top:
					# checck to see if opening goes nowhere
					if k.BoxelPosition.y + y == 0:
						return false
					# check if something above
					else:
						if virtualFloor[k.BoxelPosition.y + y - 1][k.BoxelPosition.x + x].active and not virtualFloor[k.BoxelPosition.y + y - 1][k.BoxelPosition.x + x].Bottom:
							return false
							
				# check the bottom of the room
				if k.boxels[y][x].Bottom:
					# checck to see if opening goes nowhere
					if k.BoxelPosition.y + y == floorSize - 1:
						return false
					# check if something below
					else:
						if virtualFloor[k.BoxelPosition.y + y + 1][k.BoxelPosition.x + x].active and not virtualFloor[k.BoxelPosition.y + y + 1][k.BoxelPosition.x + x].Top:
							return false
							
				# check the left of the room
				if k.boxels[y][x].Left:
					# checck to see if opening goes nowhere
					if k.BoxelPosition.x + x == 0:
						return false
					# check if something to the left
					else:
						if virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x - 1].active and not virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x - 1].Right:
							return false
							
				# check the right of the room
				if k.boxels[y][x].Right:
					# checck to see if opening goes nowhere
					if k.BoxelPosition.x + x == floorSize - 1:
						return false
					# check if something to the left
					else:
						if virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x + 1].active and not virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x + 1].Left:
							return false
	return true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
