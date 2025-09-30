extends StaticBody2D

@onready var animated_sprite = $Sprite2D
@export var type: String = ""

const HAM = preload("res://ui/inventory/items/ham.tres")


var item: Item = null
var just_spawned = true

func _ready() -> void:
	var random_number = str(randi_range(1,4))
	item = HAM
	match random_number:
		1:
			type = "ham"
	animated_sprite.play(random_number)
	await get_tree().create_timer(0.5).timeout
	just_spawned = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_action():
	match type:
		"gem":
			return
		_:
			print("error in random object action")
			
