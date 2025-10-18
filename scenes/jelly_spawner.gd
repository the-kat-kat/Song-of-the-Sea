extends Node2D

var jelly_path = preload("res://scenes/environment/jelly.tscn")
@export var jelly_count = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in jelly_count:
		var jelly = jelly_path.instantiate()
		add_child(jelly)
		
