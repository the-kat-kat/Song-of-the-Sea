"""
class_name Menu extends VBoxContainer

signal actioned(item: Control)

@export var pointer: Node

func ready():
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	configure_focus()

func _unhandled_input(event):
	if not visible: return
	
	get_viewport().set_input_as_handled()
	
	var item = get_focused_item()
	if is_instance_valid(item) and event.is_action_pressed("ui_accept"):
		actioned.emit(item)

func get_items() -> Array[Control]:
	var items: Array[Control] = []
	for child in get_children():
		if not child is Control: continue
		if "Heading" in child.name: continue
		if "Divider" in child.name: continue
		items.append(child)
		
	return items
		
func configure_focus() -> void:
	var items = get_items()
	for i in items.size():
		var item: Control = items[i]
		
		item.focus_mode = Control.FOCUS_ALL
		
		item.focus_neighbor_left = item.get_path()
		item.focus_neighbor_right = item.get_path()
		
		if i==0:
			item.focus.neighbor_top = item.get_path()
			item.focsu.previous_focus = item.get_path()
			item.grab_focus()
		else:
			item.focus.neighbor_top = items[i-1].get_path()
			item.focus.previous_focus = items[i-1].get_path()
			
		if i==items.size() -1:
			item.focus.neighbor_bottom = item.get_path()
			item.focus_next = item.get_path()
		else:
			item.focus_neighbor_bottom = items[i+1].get_path()
			item.focus_next = items[i+1].get_path()
			
func get_focused_item() -> Control:
	var item = get_viewport().get_gui_focus_owner()
	if item in get_children():
		return item
	else:
		return null
	
func _on_focus_changed(item: Control)-> void:
	if not item: return
	if not item in get_children(): return
	
func _update_selection() -> void:
	var item = get_focused_item()

"""
