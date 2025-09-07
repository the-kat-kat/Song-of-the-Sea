extends CharacterBody2D

@export var speed := 500.0
@export var water_resistance := 2.0

@export var dash_speed := 2000.0
@export var dash_time := 0.4
@export var dash_cooldown := 1
@export var player_audiostream: AudioStreamPlayer2D

@onready var playerAnim = $Sprite2D
@onready var actionable_finder = $ActionableFinder

var is_dashing := false
var dash_timer := 0.0
var cooldown_timer := 0.0
var last_move_direction: Vector2 = Vector2.RIGHT
var current_audio_clip := "none"

func _physics_process(delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()

	if input_vector != Vector2.ZERO:
		last_move_direction = input_vector

	if Input.is_action_just_pressed("dash") and not is_dashing and cooldown_timer <= 0.0:
		is_dashing = true
		var dash_dir := input_vector if input_vector != Vector2.ZERO else last_move_direction
		dash_timer = dash_time
		cooldown_timer = dash_cooldown
		velocity = dash_dir * dash_speed

	if is_dashing:
		update_player_audio("dash")
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false

	if input_vector == Vector2.ZERO:
		playerAnim.play("default")
	else:
		playerAnim.play("swim")

	if input_vector.x != 0.0:
		playerAnim.flip_h = input_vector.x < 0.0

	input_vector.y += 0.1
	velocity = velocity.lerp(input_vector * speed, water_resistance * delta)

	if cooldown_timer > 0.0:
		cooldown_timer -= delta

	move_and_slide()

	if Input.is_action_just_pressed("ui_accept"):
		print("pressed space")
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0 and actionables[0].has_method("action"):
			print("calling action on actionable")
			actionables[0].action()

func update_player_audio(name: String) -> void:
	if name == "none":
		player_audiostream.stop()
		current_audio_clip = "none"
		return

	if name != current_audio_clip:
		# swap stream here
		player_audiostream.play()
		current_audio_clip = name
	elif name == "dash":
		player_audiostream.play()
