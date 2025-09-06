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

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input_vector = input_vector.normalized()
	
	input_vector.y += 0.1
	
	if Input.is_action_just_pressed("dash") and not is_dashing and cooldown_timer <= 0:
		if input_vector != Vector2.ZERO:
			is_dashing = true
			dash_timer = dash_time
			cooldown_timer = dash_cooldown
			velocity = input_vector * dash_speed
			
	if is_dashing:
		update_player_audio("dash")
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	
	if(input_vector == Vector2.ZERO):
		playerAnim.play("default")
	else:
		playerAnim.play("swim")
	
	# Smooth acceleration and resistance
	velocity = velocity.lerp(input_vector * speed, water_resistance * delta)
	
	if cooldown_timer > 0:
		cooldown_timer -= delta
	
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		print_debug("pressed space")
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() >0:
			print_debug("there are some actionables")
			actionables[0].action()
			return

func update_player_audio(name: String):
	if name == "none":
		player_audiostream.stop()
	if name != player_audiostream["parameters/switch_to_clip"]:
		player_audiostream.play()
		player_audiostream["parameters/switch_to_clip"] = name
	else:
		if name == "dash":
			player_audiostream.play()
