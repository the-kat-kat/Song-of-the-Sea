extends Node2D

@export var player: CharacterBody2D
@export var enemy: CharacterBody2D

func reset():
	enemy.active = false
	player.global_position = Vector2.ZERO
	enemy.global_position = Vector2(1428, 505)
	enemy.velocity = Vector2.ZERO
	enemy.set_deferred("velocity", Vector2.ZERO)
	enemy.player_chase = false
	enemy.set_deferred("player_chase", false)
	enemy.touching_player = false
	enemy.set_deferred("touching_player", false)
	print_debug(enemy.velocity)
	print_debug(enemy.player_chase)
	
	await get_tree().create_timer(1.0).timeout
	enemy.velocity = Vector2.ZERO
	enemy.set_deferred("velocity", Vector2.ZERO)
	enemy.player_chase = false
	enemy.set_deferred("player_chase", false)
	enemy.touching_player = false
	enemy.set_deferred("touching_player", false)
	enemy.active = true
