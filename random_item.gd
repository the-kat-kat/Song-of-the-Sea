extends StaticBody2D

@onready var animated_sprite = $Sprite2D

@export var type: String = ""

var just_spawned = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_number = str(randi_range(1,4))
	match random_number:
		1:
			type = "gem"
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
			
