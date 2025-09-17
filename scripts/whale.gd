extends Node2D

@export var interact_icon: Sprite2D
@onready var player = get_tree().get_nodes_in_group("player")[0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_icon.visible = false


func _on_whale_actionable_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_icon.visible = true


func _on_whale_actionable_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_icon.visible = false
