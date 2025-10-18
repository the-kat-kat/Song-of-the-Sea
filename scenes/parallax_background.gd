extends ParallaxBackground

@export var parallax_strength := 0.05

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_center = get_viewport().size / 2.0
	var offset = (mouse_pos - screen_center) * parallax_strength

	for layer in get_children():
		if layer is Sprite2D:
			layer.position = -offset * (get_children().find(layer) + 1) * 0.3
