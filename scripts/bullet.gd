extends CharacterBody2D

var pos: Vector2
var rota: float
var speed = 400.0

	
func set_up(pos: Vector2, rota: float):
	global_position = pos
	global_rotation = rota
	print("rota",rota)
	velocity = Vector2(speed, 0).rotated(rota)

func _physics_process(delta):
	if((global_position-pos).length() > 5000):
		queue_free()
	move_and_slide()
