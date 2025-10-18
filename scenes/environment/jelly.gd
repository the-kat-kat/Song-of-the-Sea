extends AnimatedSprite2D

var wait_time = 3.0

func _ready() -> void:
	randomize()
	random_move()

func random_move() -> void:
	await get_tree().create_timer(wait_time).timeout
	wait_time = randf()*5
	position = Vector2(randf_range(-1500,1500),randf_range(-800,800))
	var scaler = randf_range(0.5, 2)
	scale = Vector2(scaler, scaler)
	play()
	await animation_finished
	random_move()
