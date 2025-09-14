extends CharacterBody2D

var speed = 280
var player_chase = false
var health = 20
var active = true

@export var player: CharacterBody2D

var touching_player = false

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	if player_chase && !touching_player:
		print("player chase", player_chase)
		var direction = (player.global_position - global_position).normalized()
		if velocity.length() == speed:
			velocity = velocity.lerp(direction * speed, 0.8 * delta)
		else:
			velocity = direction * speed
	elif velocity.length() > 0:
		velocity = velocity.lerp(Vector2.ZERO, 0.8 * delta)
		
	if velocity.length() > speed:
		velocity = -velocity.normalized()* speed * 0.5
		player_chase = true
		touching_player = false
	move_and_slide()

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_chase = true
	elif area.is_in_group("bullet"):
		health -= 5

func _on_detection_area_area_exited(area: Area2D) -> void:
	player_chase = false
	
func set_touching_player(touching: bool):
	touching_player = touching
	
func set_player_chase(chase: bool):
	player_chase = chase
