extends Node2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@export var enemy_array: Array[Node]
@onready var enemy_spawner = get_tree().get_nodes_in_group("enemy_spawner")[0]

var currently_equipped: Item = null

func get_enemy_array():
	enemy_array = get_tree().get_nodes_in_group("enemy")

func reset():
	print("died")
	for enemy in enemy_array:
		if enemy:
			enemy.queue_free()
			enemy_spawner.enemies_spawned -= 1
		player.global_position = Vector2(-443, -543)
		print("main pos", player.global_position)
	print(enemy_spawner.enemies_spawned)
