extends Node2D
var enemy_path = preload("res://scenes/environment/enemy.tscn")

@export var max_enemies: int = 3
var enemies_spawned = 0
@onready var main = get_tree().get_nodes_in_group("main")[0]

@export var spawn_interval = 5.0

var enemy_spawn_positions: Array[Vector2] = []

func _ready():
	for child in get_children():
		enemy_spawn_positions.append(child.global_position)
	
	#spawn_loop()
	
func respawn():
	for enemy_pos in enemy_spawn_positions:
		spawn_enemy(enemy_pos)

func spawn_loop():
	await get_tree().create_timer(spawn_interval).timeout
	
	if enemies_spawned < max_enemies:
		pass
		#spawn_enemy()
		
	spawn_loop()

func spawn_enemy(pos: Vector2):
	call_deferred("_spawn_enemy_safe", pos)

func _spawn_enemy_safe(pos: Vector2):
	enemies_spawned += 1
	var enemy = enemy_path.instantiate()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy.global_position = pos
	enemy.velocity = Vector2.ZERO
	main.get_enemy_array()
