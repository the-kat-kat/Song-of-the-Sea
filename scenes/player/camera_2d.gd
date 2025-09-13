extends Camera2D

var shake_time: float = 0.0
var shake_duration: float = 0.0
var shake_intensity: float = 0.0
var original_position: Vector2
var original_rotation: float = 0.0

func _ready() -> void:
	original_position = position
	original_rotation = rotation

func start_shake(intensity: float, duration: float) -> void:
	shake_intensity = intensity
	shake_duration = duration
	shake_time = duration
	original_position = position
	original_rotation = rotation

func _process(delta: float) -> void:
	if shake_time > 0.0:
		shake_time -= delta
		var t= 0.0
		if shake_duration > 0.0:
			t = shake_time / shake_duration
		var strength= shake_intensity * t
		var offset = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * strength
		var rot_strength = (strength * 0.6) * (PI / 180.0)
		rotation = original_rotation + randf_range(-rot_strength, rot_strength)
		position = original_position + offset
		if shake_time <= 0.0:
			position = original_position
			rotation = original_rotation
