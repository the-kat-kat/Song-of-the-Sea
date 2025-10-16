extends Node2D

@onready var texture_rect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $SubViewport.get_children():
		child.queue_free()
	var new_scene = load("res://scenes/level1_full.tscn").instantiate()
	$SubViewport.add_child(new_scene)
	texture_rect.material.set_shader_parameter("tint_color", Vector3(1, 1, 1))
	texture_rect.material.set_shader_parameter("tint_strength", 0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
