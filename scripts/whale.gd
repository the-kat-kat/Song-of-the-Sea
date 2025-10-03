extends Node2D

@export var dialogue_resource: DialogueResource
@export var interact_icon: Sprite2D
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var actionable = $WhaleActionable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_icon.visible = false
	actionable.dialogue_resource = dialogue_resource


func _on_whale_actionable_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_icon.visible = true


func _on_whale_actionable_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_icon.visible = false
