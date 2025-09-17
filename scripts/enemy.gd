extends CharacterBody2D
var random_item_path = preload("res://scenes/random_item.tscn")

var speed = 280
var player_chase = false
var health = 100
var active = true

@onready var player = get_tree().get_nodes_in_group("player")[0]
@export var max_health = 100

@onready var health_bar = $ProgressBar

var touching_player = false

func _ready():
	health_bar.max_value = max_health
	health_bar.value = max_health
	health = max_health

func _physics_process(delta: float) -> void:
	if not active:
		return
		
	if touching_player:
		health -=5
	
	if player_chase && !touching_player:
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
		print_debug("detected", area.name)
		player_chase = true

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_chase = false
	
	
func set_touching_player(touching: bool):
	touching_player = touching
	
func set_player_chase(chase: bool):
	player_chase = chase
	
func die():
	queue_free()

func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		print_debug("bullet")
		body.queue_free()
		health -= 50
		health_bar.value = max(0, health)
		if health<=0:
			print_debug("died")
			spawn_random_item()
			die()
			
func spawn_random_item():
	var random_item = random_item_path.instantiate()
	random_item.position = position
	get_parent().call_deferred("add_child", random_item)
