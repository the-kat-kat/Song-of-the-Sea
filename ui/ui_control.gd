extends Control

@onready var buttonWeird = $CanvasLayer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttonWeird.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	print("Button was pressed by code connection!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
