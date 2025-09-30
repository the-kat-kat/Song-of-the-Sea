extends Control

var current_scene

@export var hotbar: HBoxContainer
@export var grid: GridContainer

func _on_hotbar_equip(item: Item) -> void:
	if current_scene != null:
		current_scene.currently_equipped = item
