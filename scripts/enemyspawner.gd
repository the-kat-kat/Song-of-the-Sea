extends Node2D
var enemy_path = preload("res://scenes/environment/enemy.tscn")

var max_enemies: int
var enemies_spawned = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while(enemies_spawned <= max_enemies):
		var enemy = enemy_path.instantiate()
		enemy.global_position = position + Vector2(randf_range(-100,100),randf_range(-100,100))
		enemies_spawned += 1
