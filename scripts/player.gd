extends CharacterBody2D
var bullet_path = preload("res://scenes/bullet.tscn")

@export var speed := 300.0
@export var water_resistance := 4.0

@export var dash_speed := 1000.0
@export var dash_time := 0.4
@export var dash_cooldown := 1

@export var bgm: AudioStreamPlayer
@export var firing_pos_array: Array[Node2D]
@onready var heart_display: HBoxContainer = get_tree().get_nodes_in_group("hearts")[0]
@onready var inventory: Control = get_tree().get_nodes_in_group("inventory")[0]

@onready var playerAnim = $Sprite2D
@onready var camera = $Camera2D
@onready var viewport = get_viewport()
@export var audio_node: AudioStreamPlayer
@onready var display_control = get_tree().get_nodes_in_group("texture_rect")[0]

@export var actionable_finder: Area2D
@export var actionable_finder_left: CollisionShape2D
@export var actionable_finder_right: CollisionShape2D
@export var collision_poly_left: CollisionPolygon2D
@export var collision_poly_right: CollisionPolygon2D

var is_dashing := false
var dash_timer := 0.0
var cooldown_timer := 0.0
var last_move_direction: Vector2 = Vector2.RIGHT
var last_dir := 1

var bounce_force = 1000.0
var invulnerable := false
var invuln_time := 0.25
var invuln_timer := 0.0

var shoot_timer = 3.0
var can_shoot = true
var number_shots = 3.0
var shoots_left = 3.0
var shoot_delay = 3.0


func _ready():
	shoots_left = number_shots
	shoot_delay = number_shots

func _physics_process(delta: float) -> void:
	
	var input_vector := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()

	if input_vector != Vector2.ZERO:
		last_move_direction = input_vector

	if Input.is_action_just_pressed("dash") and not is_dashing and cooldown_timer <= 0.0:
		audio_node.stop()
		audio_node.play()
		is_dashing = true
		var dash_dir := input_vector if input_vector != Vector2.ZERO else last_move_direction
		dash_timer = dash_time
		cooldown_timer = dash_cooldown
		velocity = dash_dir * dash_speed

	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false

	if input_vector.x == 0:
		playerAnim.play("default")
	else:
		playerAnim.play("swim")
		playerAnim.flip_h = input_vector.x < 0
		if(input_vector.x > 0):
			for firing_pos in firing_pos_array:
				firing_pos.position.x = abs(firing_pos.position.x)
				firing_pos.rotation = abs(firing_pos.rotation)
			collision_poly_left.set_deferred("disabled", false)
			collision_poly_right.set_deferred("disabled", true)
			actionable_finder_left.set_deferred("disabled", false)
			actionable_finder_left.set_deferred("disabled", true)
		else:
			for firing_pos in firing_pos_array:
				firing_pos.rotation = -abs(firing_pos.rotation)
				firing_pos.position.x = -abs(firing_pos.position.x)
			collision_poly_left.set_deferred("disabled",  true)
			collision_poly_right.set_deferred("disabled", false)
			actionable_finder_left.set_deferred("disabled", true)
			actionable_finder_left.set_deferred("disabled", false)
		
	input_vector.y += 0.1
	velocity = velocity.lerp(input_vector * speed, water_resistance * delta)

	if cooldown_timer > 0.0:
		cooldown_timer -= delta

	move_and_slide()

	
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		for actionable in actionables:
				if actionable.has_method("action"):
					actionable.action()
			
	if shoots_left < number_shots:
		shoot_timer += delta
		if shoot_timer >= shoot_delay/number_shots:
			shoots_left = floor(shoot_timer * number_shots/shoot_delay)
			can_shoot = true
		else:
			shoots_left = 0
			can_shoot = false
			

func fire():
	if can_shoot:
			shoots_left -= 1
			shoot_timer -= shoot_delay/number_shots
			
			for firing_pos in firing_pos_array:
				var bullet = bullet_path.instantiate()
				var bullet_direction = Vector2(firing_pos.global_position - global_position)
				var bullet_rota = bullet_direction.angle()
				bullet.set_up(firing_pos.global_position, bullet_rota)
				get_parent().add_child(bullet)

func _on_actionable_finder_body_entered(body: Node2D) -> void:
	if body.is_in_group("random_item"):
		touching_random_item(body)
		
	if body.is_in_group("enemy"):
		touching_enemy(body)

func _on_actionable_finder_body_exited(body: Node2D) -> void:
	if not body.is_in_group("enemy"):
		return
	body.touching_player = false
	
func touching_enemy(body: Node2D):
	audio_node.play()
	heart_display.take_damage(0.2)
	camera.start_shake(80.0, 1)

	var away = (global_position - body.global_position).normalized()
	velocity = away * bounce_force
	##body.velocity = -away * bounce_force
	body.touching_player = true
	
func touching_random_item(body: Node2D):
	if !body.just_spawned:
		inventory.add_item(body.item)
		body.queue_free()
