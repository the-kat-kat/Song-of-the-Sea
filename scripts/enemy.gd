extends CharacterBody2D

var speed = 280
var player_chase = false

var player = null

var touching_player = false

func _physics_process(delta: float) -> void:
	if player_chase && !touching_player:
		var direction = (player.global_position - global_position).normalized()
		if velocity.length() == speed:
			velocity = velocity.lerp(direction * speed, 0.8 * delta)
		else:
			velocity = direction * speed
	elif velocity.length() > 0:
		velocity = velocity.lerp(Vector2.ZERO, 0.8 * delta)
	move_and_slide()

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player = area
		player_chase = true

func _on_detection_area_area_exited(area: Area2D) -> void:
	player = null
	player_chase = false
	
func set_touching_player(touching: bool):
	touching_player = touching
