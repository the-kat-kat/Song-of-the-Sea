extends AnimatedSprite2D

var wait_time = 3.0
var range_x: Vector2
var range_y: Vector2

func _ready() -> void:
	randomize()
	wait_time = randf_range(1.0, 5.0)
	random_move()

func random_move() -> void:
	randomize()
	play()
	await animation_finished
	
	wait_time = randf_range(1.0, 5.0)
	global_position = Vector2(randf_range(range_x.x,range_x.y),randf_range(range_y.x,range_x.x))
	var scaler = randf_range(0.1, 0.7)
	scale = Vector2(scaler, scaler)
	
	await get_tree().create_timer(wait_time).timeout
	random_move()
