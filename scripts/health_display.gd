extends HBoxContainer

var max_health = 3.0
var health = 3.0

@onready var hearts = get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func take_damage():
	if(health == 0):
		print_debug("died")
	else:
		health -= 0.5
		print_debug("heath", health)
		for i in range(1, max_health+1):
			if i <= health:
				print_debug("show", i)
				hearts[i-1].show()
			else:
				print_debug("hide", i)
				hearts[i-1].hide()
		
