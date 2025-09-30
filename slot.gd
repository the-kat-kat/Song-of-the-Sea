extends Panel

@export var item: Item = null:
	set(value):
		item = value
		
		if value == null:
			$Icon.texture = null
			$Amount.text = ""
			return
		
		$Icon.texture = value.icon
		
		
@export var amount: int = 0:
	set(value):
		amount = value
		$Amount.text = str(value)
		if amount <= 0:
			item = null

func set_amount(value: int):
	amount = value
	
func add_amount(value: int):
	amount += value
	
func _can_drop_data(at_position: Vector2, data: Variant):
	if "item" in data:
		return is_instance_of(data.item, Item)
	return false
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = item
	item = data.item
	data.item = temp
	
	temp = amount
	amount = data.amount
	data.amount = temp
	
func _get_drag_data(at_position: Vector2) -> Variant:
	if not item:
		return self

	var preview = PanelContainer.new()
	preview.custom_minimum_size = Vector2(64, 64)
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var preview_texture = TextureRect.new()
	preview_texture.texture = item.icon
	preview_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview_texture.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	preview_texture.size_flags_vertical = Control.SIZE_EXPAND_FILL
	preview_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE

	preview.add_child(preview_texture)
	preview.scale = Vector2(0.13, 0.13)
	set_drag_preview(preview)
	return self
