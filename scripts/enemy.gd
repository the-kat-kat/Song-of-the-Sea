extends CharacterBody2D
var random_item_path = preload("res://scenes/random_item.tscn")

var rotate = 0.0

var speed = 280
var player_chase = false
var health = 100
var active = true

var enemy_spawner: Node2D

@onready var player
@onready var enemyAnim = $AnimatedSprite2D
@export var max_health = 100

@onready var health_bar = $ProgressBar

var touching_player = false
var bouncing_back = false

var drift_direction := Vector2.ZERO
var drift_timer := 0.0
var drift_interval := 5.0

var can_take_damage = true

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	
	enemy_spawner = get_tree().get_nodes_in_group("enemy_spawner")[0]
	health_bar.max_value = max_health
	health_bar.value = max_health
	health = max_health
	#change color
	var r = randf_range(180, 250)
	var g = randf_range(180, 250)
	var b = randf_range(180, 250)

	#enemyAnim.modulate = Color.from_rgba8(r, g, b)
	#change speed
	enemyAnim.speed_scale= randf_range(0.8, 1.2)
	enemyAnim.play()


func _physics_process(delta: float) -> void:
	if !active || !player || player.in_dialogue:
		return
	
	#await get_tree().create_timer(0.1).timeout
	
	if touching_player:
		if can_take_damage:
			print("take damage")
			update_health(10)
			can_take_damage = false
			
	if bouncing_back:
		move_and_slide()
		return
		
	else:
		if !can_take_damage:
			can_take_damage = true
	
	if player_chase && !touching_player:
		var direction = (player.global_position - global_position).normalized().rotated(rotate)
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
		velocity = velocity.normalized()* speed
		#player_chase = true
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
		update_health(10)
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

func start_bounce_delay() -> void:
	touching_player = true
	bouncing_back = true
	await get_tree().create_timer(0.05).timeout
	bouncing_back = false
	player_chase = true
	# clear touching flag
	touching_player = false
