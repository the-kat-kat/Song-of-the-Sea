extends Node2D

var current_level: int = 0

@onready var main: Node2D 

@onready var heart_display: HBoxContainer 
@onready var inventory: Control 
@onready var player: CharacterBody2D
@onready var default_main: Node2D 

var dark_overlay: ColorRect

signal player_set(player_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	return
	
func change_scene(path: NodePath):
	print("change scene")
	get_tree().change_scene_to_file(path)
	
func set_player(player_node: Node) -> void:
	print("set player")
	player = player_node
	emit_signal("player_set", player)
	
func _on_scene_changed() -> void:
	# Wait one frame so groups get registered
	await get_tree().process_frame
	default_main = get_tree().get_nodes_in_group("default_main")[0]
	main = get_tree().get_nodes_in_group("main")[0]
	heart_display = get_tree().get_nodes_in_group("heart_display")[0]
	inventory = get_tree().get_nodes_in_group("inventory")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	
	set_player(player)

func inc_level():
	current_level += 1
