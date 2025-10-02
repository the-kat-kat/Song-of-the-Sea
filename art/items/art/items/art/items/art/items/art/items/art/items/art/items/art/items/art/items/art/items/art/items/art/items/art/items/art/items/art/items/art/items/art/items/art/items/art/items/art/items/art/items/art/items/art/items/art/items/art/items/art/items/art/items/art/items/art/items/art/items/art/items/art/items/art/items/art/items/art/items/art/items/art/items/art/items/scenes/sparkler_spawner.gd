extends Node2D

var sparkle_path = preload("res://sparkle.tscn")
@export var sparkle_count = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in sparkle_count:
		var sparkle = sparkle_path.instantiate()
		add_child(sparkle)
