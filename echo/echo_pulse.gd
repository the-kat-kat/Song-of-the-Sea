extends Node2D

@export var max_radius: float = 800.0
@export var speed: float = 400.0
@export var line_thickness: float = 4.0
@export var pulse_color: Color = Color(1.0, 1.0, 1.0, 0.8)

var radius: float = 0.0
var alpha: float = 1.0

func _ready() -> void:
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	radius += speed * delta
	alpha = 1.0 - (radius/ max_radius)
	
	if alpha <= 0.0:
		queue_free()
		
	queue_redraw()
	
func _draw():
	var color = pulse_color
	color.a = alpha
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 128, color, line_thickness)
