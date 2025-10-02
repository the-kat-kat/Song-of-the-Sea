extends CharacterBody2D

var direction: Vector2
var speed = 500
var firing_pos: Vector2


func shoot():
	firing_pos=position
	velocity = direction * speed
	
func _physics_process(delta):
	if((position-firing_pos).length() > 1000):
		queue_free()
	move_and_slide()
