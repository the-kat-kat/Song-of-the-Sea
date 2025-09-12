extends CharacterBody2D

var speed = 100
var player_chase = false

var player = null


func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.global_position-position)/speed

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player = area
		player_chase = true

func _on_detection_area_area_exited(area: Area2D) -> void:
	player = null
	player_chase = false
