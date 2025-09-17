extends Node2D
var enemy_path = preload("res://scenes/environment/enemy.tscn")

@export var max_enemies: int = 5
var enemies_spawned = 0


@export var spawn_interval = 5.0

func _ready() -> void:
	spawn_loop()

func spawn_loop() -> void:
	while enemies_spawned < max_enemies:
		var enemy = enemy_path.instantiate()
		add_child(enemy)
		enemy.global_position = position + Vector2(randf_range(-300, 300), randf_range(-300, 300))
		enemy.velocity = Vector2.ZERO
		enemies_spawned += 1
		await get_tree().create_timer(spawn_interval).timeout
