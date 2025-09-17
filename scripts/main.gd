extends Node2D

@export var player: CharacterBody2D
@export var enemy_array: Array[CharacterBody2D] = []

func reset():
	for enemy in enemy_array:
		enemy.active = false
		player.global_position = Vector2.ZERO
		enemy.global_position = Vector2(randf_range(200,1000),randf_range(-1000,1000))
		enemy.velocity = Vector2.ZERO
		enemy.set_deferred("velocity", Vector2.ZERO)
		enemy.player_chase = false
		enemy.set_deferred("player_chase", false)
		enemy.touching_player = false
		enemy.set_deferred("touching_player", false)
	
	await get_tree().create_timer(1.0).timeout
	for enemy in enemy_array:
		player.global_position = Vector2.ZERO
		enemy.velocity = Vector2.ZERO
		enemy.set_deferred("velocity", Vector2.ZERO)
		enemy.player_chase = false
		enemy.set_deferred("player_chase", false)
		enemy.touching_player = false
		enemy.set_deferred("touching_player", false)
		enemy.health = 100
		enemy.health_bar.value = 100
		enemy.active = true
