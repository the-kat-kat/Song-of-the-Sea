extends ColorRect

var pulse_speed: float = 600.0
var max_radius: float = 1600.0
var pulse_active: bool = false

@onready var viewport_size: Vector2 = get_viewport().get_visible_rect().size

var shader_mat: Material

func _ready() -> void:
	get_overlay()

#ring moves out
func _process(delta: float) -> void:
	if pulse_active:
		var radius = shader_mat.get_shader_parameter("pulse_radius") + pulse_speed * delta
		shader_mat.set_shader_parameter("pulse_radius", radius)
		var fade = 1.0 - (radius / max_radius)
		shader_mat.set_shader_parameter("fade", fade)
		if radius >= max_radius:
			pulse_active = false
			shader_mat.set_shader_parameter("fade", 0.0)
			
#get the shader mat
func get_overlay():
	if is_instance_valid(GameManager.player):
		shader_mat = GameManager.player.get_node("CanvasLayer").get_node("DarkOverlay").material
	else:
		GameManager.player= get_tree().get_first_node_in_group("player")
		shader_mat = GameManager.player.get_node("CanvasLayer").get_node("DarkOverlay").material
		
func emit_pulse(center: Vector2) -> void:
	if shader_mat == null:
		get_overlay()
	shader_mat.set_shader_parameter("pulse_center", center)
	shader_mat.set_shader_parameter("screen_size", viewport_size)
	shader_mat.set_shader_parameter("pulse_radius", 0.0)
	shader_mat.set_shader_parameter("fade", 1.0)
	pulse_active = true
	
