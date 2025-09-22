extends Button

signal request_swap(from_index: int, to_index: int)
signal request_pickup(slot_index:int)
signal request_drop(slot_index:int, data)

var slot_index := -1
@onready var button_icon = $Icon

# Called when the node enters the scene tree for the first time.
func set_item(item: Dictionary) -> void:
	if item:
		icon.texture = item.get("icon", null)
		visible = true
	else:
		icon.texture = null
		visible = true

func get_drag_data(position: Vector2):
	var drag_data = {"from": slot_index}
	if icon.texture:
		var preview = TextureRect.new()
		preview.texture = icon.texture
		preview.custom_minimum_size = Vector2(32, 32)
		set_drag_preview(preview)
	return drag_data
	
func can_drop_data(position: Vector2, data) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("from")

func drop_data(position: Vector2, data) -> void:
	if data.has("from"):
		emit_signal("request_swap", data["from"], slot_index)
