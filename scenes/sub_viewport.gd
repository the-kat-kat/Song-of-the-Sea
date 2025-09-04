extends SubViewport

func _ready():
	_update_size()

func _notification(what):
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		_update_size()

func _update_size():
	var window_size = get_tree().root.get_visible_rect().size
	size = window_size
