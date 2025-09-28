extends Control

@onready var inventory = preload("res://ui/inventory/inventory.gd")
@onready var slots = get_children()
var is_open = false

func _ready():
	close()

func _process(_delta):
	if Input.is_action_just_pressed("i"):
		print_debug("i")
		if is_open:
			close()
		else:
			open()
			
	## for i in range(slots.size()):
		## var inventory_slot = inventory.slots[i]
		## slots[i].update_to_slot(inventory_slot)
	
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
