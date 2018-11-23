extends Node

var path = "res://assets/scenes/testRoom.tscn"
var health = [ 10, 10 ]

var sfxStream
var musicStream
var priestStream

func _ready():
	sfxStream = AudioStreamPlayer.new()
	musicStream = AudioStreamPlayer.new()
	priestStream = AudioStreamPlayer.new()
	add_child(sfxStream)
	add_child(musicStream)
	add_child(priestStream)
	priestStream.connect("finished", self, "enchantSignal")

func initializeGame():
	health = [ 10, 10 ]
	
func playSound(sound):
	sfxStream.stream = load(sound)
	sfxStream.play()
func playMusic(sound):
	musicStream.stream = load(sound)
	musicStream.play()
func playPriest(sound):
	priestStream.stream = load(sound)
	priestStream.play()
	
func enchantSignal():
	for c in get_tree().get_nodes_in_group("priest"):
		c.enchant()