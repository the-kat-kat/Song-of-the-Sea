extends Node3D

@export var follow_target: Node3D
@export var follow_speed := 5.0
@export var fixed_z := 4.0 

func _process(delta):
	if follow_target:
		var target_pos = follow_target.global_transform.origin
		target_pos.z = fixed_z

		global_transform.origin = global_transform.origin.lerp(
			target_pos,
			follow_speed * delta
		)
