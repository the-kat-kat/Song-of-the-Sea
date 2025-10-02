extends StaticBody2D

@onready var animated_sprite = $Sprite2D
@export var type: String = ""

const SHIELD = preload("res://ui/inventory/items/shield.tres")
const CAT = preload("res://ui/inventory/items/cat.tres")

var item: Item = null
var just_spawned = true

func _ready() -> void:
	randomize()
	var random_number = str(randi_range(1,2))
	match random_number:
		"1":
			type = "shield" 
			item = SHIELD
			animated_sprite.play("1")
		"2":
			type = "cat"
			item = CAT
			animated_sprite.play("2")
		_:
			print("unexpected random_number:", random_number)
	print("item spawnerd", item)
	await get_tree().create_timer(0.1).timeout
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
			
