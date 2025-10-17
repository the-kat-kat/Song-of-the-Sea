extends HBoxContainer
 
var max_health = 5.0
var health = 5.0

@onready var hearts = get_children()
@onready var label = $TextureRect/Label

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
	label.text = str(health)
	
	
func take_damage(damage: float):
	health -= damage
	for i in range(1, 6):
		if i <= health:
			hearts[i-1].show()
		else:
			hearts[i-1].hide()
	if(health <= 0):
		main.reset()
		health = max_health
		for i in range(1, 6):
			hearts[i-1].show()
		
