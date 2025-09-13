extends CharacterBody2D

@export var speed := 200.0
@export var water_resistance := 4.0

@export var dash_speed := 300.0
@export var dash_time := 0.4
@export var dash_cooldown := 1

@export var bgm: AudioStreamPlayer

@onready var playerAnim = $Sprite2D
@onready var actionable_finder = $ActionableFinder
@onready var collisionPoly = $CollisionPolygon2D
@onready var camera = $Camera2D
@export var audio_node: AudioStreamPlayer

var is_dashing := false
var dash_timer := 0.0
var cooldown_timer := 0.0
var last_move_direction: Vector2 = Vector2.RIGHT
var last_dir := 1

var bounce_force = 500.0

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
			collisionPoly.scale.x = 14
			actionable_finder.scale.x =1 
		else:
			collisionPoly.scale.x = -14
			actionable_finder.scale.x = -1 
		
	input_vector.y += 0.1
	velocity = velocity.lerp(input_vector * speed, water_resistance * delta)

	if cooldown_timer > 0.0:
		cooldown_timer -= delta

	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		print_debug("interact")
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0 and actionables[0].has_method("action"):
			actionables[0].action()


func _on_actionable_finder_body_entered(body: Node2D) -> void:
	if(body.is_in_group("enemy")):
		audio_node.play()
		camera.start_shake(18.0, 2)
		var enemy = body
		var away = (global_position-body.global_position).normalized()
		velocity = away * bounce_force
		var enemy_char = enemy
		enemy_char.velocity = -away * bounce_force
		move_and_slide()
