extends Node2D

#@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var texture_rect = $TextureRect
@onready var black_out: ColorRect = $CanvasLayer/BlackOut

var black_out_time = 1.0
var t = 0.0
var switching = false #switching to new scene
var fade_in = true #fade in black out panel
var new_scene_path: NodePath

signal main_scene_loaded(scene_root: Node)

func _ready() -> void:
	black_out.visible = false
	black_out.color = Color("BLACK", 0.0)
	print("blackout_path", black_out.get_path())
		
	emit_signal("main_scene_loaded")
	
	GameManager.default_main = self
	
	#switching viewport scene
func switch_vp_scene(path: NodePath):
	black_out.visible = true
	new_scene_path = path
	switching = true
	new_scene_reset()
	GameManager.switch_viewport_scene()

func new_scene_reset():
	#queue free old scene
	for child in $SubViewport.get_children():
		child.queue_free()
	await get_tree().process_frame
	var new_scene = load(new_scene_path).instantiate()
	$SubViewport.add_child(new_scene)
	
	#reset references to nodes
	GameManager.player = get_tree().get_nodes_in_group("player")[0]
	GameManager.main = get_tree().get_nodes_in_group("main")[0]
	
	#reset shader
	reset_shader()
	
	fade_in = false
	switching = true
		
func _physics_process(delta: float) -> void:
	if switching:
		if fade_in:
			t += delta / black_out_time
		else:
			t -= delta / black_out_time
		black_out.color = Color("BLACK", t)
		if t >= 1:
			if fade_in:
				switching = false
				new_scene_reset()
		elif t<=0:
			if !fade_in:
				switching = false
				black_out.visible = false
			
func level1():
	switch_vp_scene("res://scenes/level1_full.tscn")
	
func reset_shader():
	texture_rect.material.set_shader_parameter("tint_color", Vector3(1, 1, 1))
	texture_rect.material.set_shader_parameter("tint_strength", 0.0)
	
