extends SubViewport

func _ready() -> void:
	_update_size()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		_update_size()

func _update_size() -> void:
	var window_size: Vector2 = get_tree().root.get_visible_rect().size
	var window_size_i: Vector2i = Vector2i(window_size)
	size = window_size_i
