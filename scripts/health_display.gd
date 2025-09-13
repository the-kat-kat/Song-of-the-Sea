extends HBoxContainer

var max_health = 3
var health = 3

@onready var hearts = get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func take_damage():
	health -= 0.5
	if(health <=0):
		print_debug("died")
	else:
		for i in range(max_health):
			if i <= health:
				hearts[i].show()
			else:
				hearts[i].hide()
		
