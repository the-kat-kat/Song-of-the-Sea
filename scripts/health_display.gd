extends HBoxContainer

var max_health = 3.0
var health = 3.0

@onready var hearts = get_children()

@onready var main: Node2D

func _ready():
	var mains = get_tree().get_nodes_in_group("main")
	if mains.size() > 0:
		main = mains[0]
	else:
		await get_tree().process_frame
		mains = get_tree().get_nodes_in_group("player")
		if mains.size() > 0:
			main = mains[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func take_damage():
	health -= 0.5
	for i in range(1, max_health+1):
		if i <= health:
			hearts[i-1].show()
		else:
			hearts[i-1].hide()
	if(health == 0):
		main.reset()
		health = max_health
		for i in range(1, max_health+1):
			hearts[i-1].show()
		
