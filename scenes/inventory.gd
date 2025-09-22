extends Panel
signal inventory_changed

var slot_path = preload("res://scenes/bullet.tscn")

@export var max_slots := 6
var items := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items.clear()
	for i in range(max_slots):
		items.append(null)

func add_item(item: Dictionary) -> bool:
	for i in range(items.size()):
		if items[i] == null:
			items[i] = item
			emit_signal("inventory_changed")
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
