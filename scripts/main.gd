extends Node2D

@onready var default_main = get_tree().get_nodes_in_group("default_main")[0]

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var inventory = get_tree().get_nodes_in_group("inventory")[0]
@export var enemy_array: Array[Node]
@onready var enemy_spawner = get_tree().get_nodes_in_group("enemy_spawner")[0]

var currently_equipped: Item = null
 
func get_enemy_array():
	enemy_array = get_tree().get_nodes_in_group("enemy")

func reset():
	for enemy in enemy_spawner.get_children():
		if enemy:
			enemy.queue_free()
		player.global_position = Vector2(-443, -543)
	
	#reset rotations
	player.global_rotation = 0.0
	player.camera.rotation = 0.0
	player.rotate = 0.0
	default_main.reset_shader()
	
	enemy_spawner.enemies_spawned = 0
	inventory.clear()
