extends CharacterBody2D

var firing_pos: Vector2
var rota: float
var speed = 300.0

@onready var sprite = $Sprite2D

func _ready():
	sprite.play()

func set_up(pos: Vector2, rota: float):
	firing_pos = pos
	global_position = firing_pos
	global_rotation = rota
	velocity = Vector2(speed, 0).rotated(rota)

func _physics_process(delta):
	if((global_position-firing_pos).length() > 200):
		queue_free()
	move_and_slide()
