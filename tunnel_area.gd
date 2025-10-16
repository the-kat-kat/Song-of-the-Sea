extends Area2D

@onready var texture_rect = get_tree().get_nodes_in_group("texture_rect")[0]
@onready var enemy_spawn = get_parent().get_parent().get_node("EnemySpawner")

@export var path_node: NodePath
@export var travel_time: float = 1.5
@export var rotate: float = 15.2
var _pending_state := {}

@export var make_dark = true

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	
	body.input_locked = true
		
	var path2d = get_node_or_null(path_node) as Path2D
	if not path2d or not path2d.curve:
		return
	
	_pending_state.body = body
	_pending_state.curve = path2d.curve
	_pending_state.t = 0.0
	_pending_state.path2d = path2d
	_pending_state.travel_time = travel_time
	_pending_state.rotate = rotate
	_pending_state.moving = true

func _physics_process(delta):
	if not _pending_state.get("moving", false):
		return
	
	var body = _pending_state.body
	var curve = _pending_state.curve
	var path2d = _pending_state.path2d
	var t = _pending_state.t
	var travel_time = _pending_state.travel_time
	var rotate = _pending_state.rotate
	
	t += delta / travel_time
	if t >= 1.0:
		t = 1.0
		for child in enemy_spawn.get_children():
			child.global_rotation = rotate
		_pending_state.moving = false
		body.input_locked = false
	
	_pending_state.t = t
	
	var distance = t * curve.get_baked_length()
	var result = curve.sample_baked_with_rotation(distance)
	
	body.global_position = path2d.to_global(result.origin)
	body.global_rotation = rotate * t
	body.rotate = rotate
	
	if make_dark:
		var texture_rect_material = texture_rect.material
		var start_tint = texture_rect_material.get_shader_parameter("tint_color")
		var end_tint = Vector3(0.2, 0.2, 0.2)
		var start_strength = texture_rect_material.get_shader_parameter("tint_strength")
		var end_strength = 1.0
		
		var tint = start_tint.lerp(end_tint, t)
		var strength = lerp(start_strength, end_strength, t)
		
		texture_rect_material.set_shader_parameter("tint_color", tint)
		texture_rect_material.set_shader_parameter("tint_strength", strength)
