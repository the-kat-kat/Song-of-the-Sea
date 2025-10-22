extends Node2D

var current_level: int = 0

@onready var main: Node2D 

@onready var heart_display: HBoxContainer 
@onready var inventory: Control 
@onready var player: CharacterBody2D 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_scene_changed(scene_root: Node) -> void:
	# Wait one frame so groups get registered
	await get_tree().process_frame
	
	main = get_tree().get_nodes_in_group("main")[0]
	heart_display = get_tree().get_nodes_in_group("heart_display")[0]
	inventory = get_tree().get_nodes_in_group("inventory")[0]
	player = get_tree().get_nodes_in_group("player")[0]

	
func switch_viewport_scene():
	current_level += 1
	main = get_tree().get_nodes_in_group("main")[0]
	player = get_tree().get_nodes_in_group("player")[0]
