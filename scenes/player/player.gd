extends CharacterBody2D

@export var speed := 500.0
@export var water_resistance := 2.0
@onready var playerAnim = $Sprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input_vector = input_vector.normalized()
	
	if(input_vector == Vector2.ZERO):
		playerAnim.play("default")
	else:
		playerAnim.play("swim")
	
	# Smooth acceleration and resistance
	velocity = velocity.lerp(input_vector * speed, water_resistance * delta)
	
	move_and_slide()
