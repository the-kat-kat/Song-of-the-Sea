extends Area2D

@export var tunnel_exit: NodePath
@export var travel_time: float = 1.5
@export var rotate= 15.2
@onready var exit_node = get_parent().get_node("ExitNode")

func _on_body_entered(body):
	if body.is_in_group("player"): 
		body.movement_locked = true
		print(body)
		print("tunnel entered!")
		body.gravity = false
		var start_pos = body.global_position
		var end_pos = exit_node.global_position
		var start_rot = body.rotation
		rotate *= PI
		print("rotate,", rotate)

		var tween = create_tween()
		tween.tween_property(body, "global_position", end_pos, travel_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.parallel().tween_property(body, "rotation", start_rot + rotate, travel_time).set_trans(Tween.TRANS_LINEAR)
		body.rotate = -rotate
		body.movement_locked = false
		
