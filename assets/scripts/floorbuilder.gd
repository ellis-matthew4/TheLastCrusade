extends Node2D

var start

var boxel = load("res://assets/scenes/Boxel.tscn")

var startRoom = load("res://assets/scenes/startRoom.tscn")
var hallway2Opposite = load("res://assets/scenes/hallway2Opposite.tscn")
var hallway2Adjacent = load("res://assets/scenes/hallway2Adjacent.tscn")
var hallway3 = load("res://assets/scenes/hallway3.tscn")
var hallway4 = load("res://assets/scenes/hallway4.tscn")
var storeRoom = load("res://assets/scenes/storeRoom.tscn")
var armory = load("res://assets/scenes/armory.tscn")
var barracks = load("res://assets/scenes/barracks.tscn")
var messHall = load("res://assets/scenes/messHall.tscn")
var conferenceRoom = load("res://assets/scenes/conferenceRoom.tscn")
var stairDown = load("res://assets/scenes/stairs.tscn")

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

signal Switch

# sets a random floor size
func setFloorSize():
	print("Setting floor size...")
	floorSize = randi()%(MAX_SIZE - MIN_SIZE) + MIN_SIZE
	for i in range(floorSize):
		var v = []
		for j in range(floorSize):
			v.append(boxel.instance())
		virtualFloor.append(v)

# marks grid points on the virtual floor has taken
func markVRoom(k):
	print("Marking virtual room " + k.type)
	for i in range(k.BoxelSize):
		for j in range(k.BoxelSize):
			virtualFloor[k.BoxelPosition.x + i][k.BoxelPosition.y + j] = k.boxels[i][j]
			k.boxels[i][j].active = true
			print("Is same?" + str((virtualFloor[k.BoxelPosition.x + i][k.BoxelPosition.y + j] == k.boxels[i][j])))

# rotates a room
func rotateRoom(k):
	print("Rotating room " + k.type)
	k.rotate()

# creates random rotation
func randRot():
	print("Generating random integer...")
	var rot = randi() % 4 + 1
	return rot

# creates a random vector
func randPos():
	var x = randi() % floorSize
	var y = randi() % floorSize
	print("Generating random position " + str(x) + ", " + str(y))
	return Vector2(x, y)

func setTruePos(k):
	print("Setting true position of room " + k.type)
	k.position = Vector2((k.BoxelPosition.x * k.BoxelSize * k.TileSize) / 2, (k.BoxelPosition.y * k.BoxelSize * k.TileSize) / 2)

# generates a floor
func genFloor():
	print("Generating floor...")
	setFloorSize()
	addStartRoom()
	while(queue.size() > 0):
		if hasOpenConnections(queue[0]):
			var pos = getPos(queue[0])
			var temp
			if queue[0].pathLength >= 8:
				temp = stairDown
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
				add_child(r)
				setTruePos(r)
				markVRoom(r)
				addToQueue(r)
				increasePathLength()
				rooms.append(r) 
		else:
			queue.pop()

func increasePathLength():
	for b in queue:
		if b.pathLength == 0:
			b.pathLength = queue[0].pathLength + 1

# adds the start room to the virtual floor and the queue
func addStartRoom():
	print("Adding start room...")
	var s = startRoom.instance()
	add_child(s)
	s.BoxelPosition = randPos()
	for i in range(randRot()):
		rotateRoom(s)
	while(not connectionsOpen(s)):
		rotateRoom(s)
	start = s
	markVRoom(start)
	addToQueue(start)
	queue[0].pathLength = 1
	rooms.append(start)

# adds the boxel to the queue
func addToQueue(k):
	print("Adding room " + k.type + " to queue...")
	for y in range(k.BoxelSize):
		for x in range(k.BoxelSize):
			if k.boxels[y][x].Top or k.boxels[y][x].Bottom or k.boxels[y][x].Left or k.boxels[y][x].Right:
				queue.append(k.boxels[y][x])

# checks to see if room has any possible open connections
func hasOpenConnections(k):
<<<<<<< HEAD
	# print("Checking room " + k.type + " for open connections...")
=======
	print("Checking boxel for open connections...")
>>>>>>> e351637dc2c49d9bd7e7107337c1b964719c2426
	var pos = getPos(k)
	if k.Top and not virtualFloor[pos.y - 1][pos.x].active:
		return true
	if k.Bottom and not virtualFloor[pos.y + 1][pos.x].active:
		return true
	if k.Left and not virtualFloor[pos.y][pos.x - 1].active:
		return true
	if k.Right and not virtualFloor[pos.y][pos.x + 1].active:
		return true
	return false

# gets the position of the boxel in the virtualFloor
func getPos(k):
<<<<<<< HEAD
	# print("Getting position for room " + k.type)
=======
	print("Getting position for boxel...")
>>>>>>> e351637dc2c49d9bd7e7107337c1b964719c2426
	for y in range(floorSize):
		for x in range(floorSize):
			print(str(x) + " " + str(y))
			if virtualFloor[y][x] == k:
				return Vector2(x, y)

# take in the current boxel, the room type, and the boxelsize
func possiblePositionsTop(k, l, BoxelSize):
	print("Checking possible top positions for room " + k.type)
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
	# print("Checking possible bottom positions for room " + k.type)
	var possible = []
	var pos = getPos(k)
	for offset in range(BoxelSize):
		var temp = Vector2(pos.x - offset, pos.y + 1)
		var free = true
		if temp.x >= 0 and temp.y >= 0:
			for y in range(BoxelSize):
				for x in range(BoxelSize):
					if virtualFloor[temp.y + y][temp.x + x].active:
						free = false
			if free:
				var tRoom = l.instance()
				add_child(tRoom)
				tRoom.BoxelPosition = temp
				for i in range(4):
					if connectionsOpen(tRoom):
						possible.append(tRoom)
					rotateRoom(tRoom)
	return possible
	
# take in the current boxel, the room type, and the boxelsize
func possiblePositionsLeft(k, l, BoxelSize):
	print("Checking possible left positions for room " + k.type)
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
	print("Checking possible right positions for room " + k.type)
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
	print("Checking open connections for room " + k.type)
	for y in range(k.BoxelSize):
		for x in range(k.BoxelSize):
			# check only the outer perimeter of the room
			if (y == 0 or y == (k.BoxelSize - 1)) or (x == 0 or x == (k.BoxelSize - 1)):
				# check the top of the room
				if k.boxels[y][x].Top:
					print("Top")
					# checck to see if opening goes nowhere
					if k.BoxelPosition.y + y == 0:
						return false
					# check if something above
					else:
						if virtualFloor[k.BoxelPosition.y + y - 1][k.BoxelPosition.x + x].active and not virtualFloor[k.BoxelPosition.y + y - 1][k.BoxelPosition.x + x].Bottom:
							return false
							
				# check the bottom of the room
				if k.boxels[y][x].Bottom:
					print("Botom")
					# checck to see if opening goes nowhere
					if k.BoxelPosition.y + y == floorSize - 1:
						return false
					# check if something below
					else:
						print(virtualFloor[k.BoxelPosition.y + y + 1][k.BoxelPosition.x + x].toString())
						if virtualFloor[k.BoxelPosition.y + y + 1][k.BoxelPosition.x + x].active and not virtualFloor[k.BoxelPosition.y + y + 1][k.BoxelPosition.x + x].Top:
							return false
							
				# check the left of the room
				if k.boxels[y][x].Left:
					print("Left")
					# checck to see if opening goes nowhere
					if k.BoxelPosition.x + x == 0:
						return false
					# check if something to the left
					else:
						if virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x - 1].active and not virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x - 1].Right:
							return false
							
				# check the right of the room
				if k.boxels[y][x].Right:
					print("Right")
					# checck to see if opening goes nowhere
					if k.BoxelPosition.x + x == floorSize - 1:
						return false
					# check if something to the left
					else:
						if virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x + 1].active and not virtualFloor[k.BoxelPosition.y + y][k.BoxelPosition.x + x + 1].Left:
							return false
	return true

func _ready():
	genFloor()
