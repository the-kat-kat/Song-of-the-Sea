extends AnimatedSprite2D

var wait_time = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(randf()*2000-100, randf()*2000-1000)
	randomize()
	play()
	await animation_finished
	random_move()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func random_move() -> void:
	await get_tree().create_timer(wait_time).timeout
	wait_time = randf()*5
	position = Vector2(randf_range(-1500,1500),randf_range(-800,800))
	var scaler = randf_range(0.5, 2)
	scale = Vector2(scaler, scaler)
	play()
	await animation_finished
	random_move()
