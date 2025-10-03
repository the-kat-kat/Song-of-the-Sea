extends CharacterBody2D
var random_item_path = preload("res://scenes/random_item.tscn")

var speed = 280
var player_chase = false
var health = 100
var active = true

var enemy_spawner: Node2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var enemyAnim = $AnimatedSprite2D
@export var max_health = 100

@onready var health_bar = $ProgressBar

var touching_player = false

var drift_direction := Vector2.ZERO
var drift_timer := 0.0
var drift_interval := 5.0

func _ready():
	enemy_spawner = get_tree().get_nodes_in_group("enemy_spawner")[0]
	health_bar.max_value = max_health
	health_bar.value = max_health
	health = max_health
	#change color
	var r = randf_range(180, 250)
	var g = randf_range(180, 250)
	var b = randf_range(180, 250)

	enemyAnim.modulate = Color.from_rgba8(r, g, b)
	#change speed
	enemyAnim.speed_scale= randf_range(0.8, 1.2)
	enemyAnim.play()

func _physics_process(delta: float) -> void:
	if not active || player.in_dialogue:
		return
		
	if touching_player:
		velocity = velocity.normalized() * -250
		update_health(30)
	
	if player_chase && !touching_player:
		var direction = (player.global_position - global_position).normalized()
		if velocity.length() != speed:
			velocity = velocity.lerp(direction * speed, 1.2 * delta)
		else:
			velocity = direction * speed
	elif !player_chase && !touching_player:
		drift_timer -= delta
		if drift_timer <= 0.0:
			drift_timer = drift_interval
			drift_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(100, 300)
		velocity = velocity.lerp(drift_direction, 0.5 * delta)
		
	if velocity.length() > speed:
		velocity = -velocity.normalized()* speed * 0.5
		player_chase = true
		touching_player = false
	move_and_slide()

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_chase = true

func _on_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_chase = false
	

func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		body.queue_free()
		update_health(30)
	if body.is_in_group("dagger"):
		body.queue_free()
		update_health(100)

func update_health(subtracted_value: float):
	health -= subtracted_value
	health_bar.value = max(0, health)
	if health<=0:
		spawn_random_item()
		enemy_spawner.enemies_spawned -= 1
		queue_free()
			
func spawn_random_item():
	var random_item = random_item_path.instantiate()
	random_item.position = position
	get_parent().call_deferred("add_child", random_item)
