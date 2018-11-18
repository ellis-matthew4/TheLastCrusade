extends Navigation2D

onready var priest = get_tree().get_nodes_in_group("priest")[0]

signal Switch

func _ready():
	priest.set_nav(self)