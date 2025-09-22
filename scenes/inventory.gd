extends Control

@onready var manager = get_node("/root/InventoryManager")
@onready var slots_grid = $Slots
@export var slot_scene: PackedScene = preload("res://ui/slot.tscn")

var slot_nodes := []

func _ready():
	for i in range(manager.max_slots):
		var s = slot_scene.instantiate()
		s.slot_index = i
		s.connect("request_swap", Callable(self, "_on_request_swap"))
		s.connect("request_pickup", Callable(self, "_on_request_pickup"))
		s.connect("request_drop", Callable(self, "_on_request_drop"))
		slots_grid.add_child(s)
		slot_nodes.append(s)
		
	_update_ui()
	manager.connect("inventory_changed", Callable(self, "_update_ui"))
	
func _update_ui():
	var items = manager.get_items()
	for i in range(items.size()):
		slot_nodes[i].set_item(items[i])

func _on_request_swap(from_idx:int, to_idx:int):
	manager.swap_slots(from_idx, to_idx)
	
func _on_request_pickup(slot_index:int):
	manager.remove_item(slot_index)
	
func _on_request_drop(slot_index:int, data):
	pass
