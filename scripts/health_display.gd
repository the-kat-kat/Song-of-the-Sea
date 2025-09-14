extends HBoxContainer

var max_health = 3.0
var health = 3.0

@onready var hearts = get_children()

@export var main: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func take_damage():
	health -= 0.5
	print_debug("heath", health)
	for i in range(1, max_health+1):
		if i <= health:
			print_debug("show", i)
			hearts[i-1].show()
		else:
			print_debug("hide", i)
			hearts[i-1].hide()
	if(health == 0):
		main.reset()
		health = max_health
		for i in range(1, max_health+1):
			hearts[i-1].show()
		
