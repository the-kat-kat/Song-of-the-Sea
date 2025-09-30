extends AudioStreamPlayer2D

@onready var player = get_tree().get_nodes_in_group("player")[0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	
