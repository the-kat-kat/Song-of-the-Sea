extends Node2D

var default_main

var player
var inventory
var enemy_array
@onready var enemy_spawner = $Environment/EnemySpawner

var currently_equipped: Item = null
 
func get_enemy_array():
	enemy_array = get_tree().get_nodes_in_group("enemy")

func reset():
	player = GameManager.player
	inventory = GameManager.inventory

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
	enemy_spawner.respawn()
	inventory.clear()
	
	GameManager.main = self
