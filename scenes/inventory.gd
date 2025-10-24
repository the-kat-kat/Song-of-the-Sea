extends Control

var current_scene

const DEFAULT = preload("res://ui/inventory/items/default.tres")

@export var hotbar: HBoxContainer
@export var grid: GridContainer

@export var inventory_button: Button 
@onready var main = get_tree().get_nodes_in_group("main")[0]

func _ready():
	visible = false
	current_scene = main
	hotbar.get_children()[0].item= DEFAULT
	GameManager.inventory = self
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("i"):
		visible = !visible
		inventory_button.visible = !visible
	
func _on_hotbar_equip(item: Item) -> void:
	if current_scene != null:
		current_scene.currently_equipped = item
		
func add_item(item: Item, amount: int = 1):
	print(item.title)
	for slot in hotbar.get_children():
		if slot.item == null:
			slot.item = item
			slot.set_amount(amount)
			hotbar.update()
			return
		elif slot.item == item:
			slot.add_amount(1)
			hotbar.update()
			return
			
func clear():
	for slot in hotbar.get_children():
		if slot.item != null && slot.item.title != "default":
			slot.item = null
	hotbar.index = 0

func _on_inventory_button_pressed() -> void:
	visible = !visible
	inventory_button.visible = !visible

func _on_button_pressed() -> void:
	visible = !visible
	inventory_button.visible = !visible
