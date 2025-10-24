extends Node2D

var jelly_path = preload("res://scenes/environment/jelly.tscn")
@export var jelly_count = 4
@export var spawner_range_x: Vector2 = Vector2(-1000, 1000)
@export var spawner_range_y: Vector2 = Vector2(-800, 800)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in jelly_count:
		var jelly = jelly_path.instantiate()
		jelly.range_x = spawner_range_x
		jelly.range_y = spawner_range_y
		add_child(jelly)
		
