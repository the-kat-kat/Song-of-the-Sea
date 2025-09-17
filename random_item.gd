extends StaticBody2D

@onready var animated_sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_number = randi_range(1,4)
	animated_sprite.play(random_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
