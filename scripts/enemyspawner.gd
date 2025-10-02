extends Node2D
var enemy_path = preload("res://scenes/environment/enemy.tscn")

@export var max_enemies: int = 3
var enemies_spawned = 0
@onready var main = get_tree().get_nodes_in_group("main")[0]

@export var spawn_interval = 5.0
  

func _ready():
	for i in max_enemies:
		spawn_enemy()
	spawn_loop()

func spawn_loop():
	await get_tree().create_timer(spawn_interval).timeout
	
	if enemies_spawned < max_enemies:
		spawn_enemy()
		
	spawn_loop()

func spawn_enemy():
	enemies_spawned += 1
	var enemy = enemy_path.instantiate()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy.global_position = position + Vector2(randf_range(-300, 300), randf_range(-300, 300))
	enemy.velocity = Vector2.ZERO
	main.get_enemy_array()
