extends Node2D

@export var interact_icon: Sprite2D
@export var area: Area2D
@export var player_node: Node2D 


var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_icon.visible = false
	player = player_node.get_node("player") as CharacterBody2D
	area.body_entered.connect(_on_area_body_entered)
	area.body_exited.connect(_on_area_body_exited)

func _physics_process(delta: float) -> void:
	if area and player:
		if area.overlaps_body(player):
			interact_icon.visible = true
		else:
			interact_icon.visible = false

func _on_area_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		interact_icon.visible = true
		
func _on_area_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		interact_icon.visible = false
