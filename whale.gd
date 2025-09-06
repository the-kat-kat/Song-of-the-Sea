extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_dialogue_balloon(load("res://dialogue/whale1.dialogue"), "intro")
		return
	
func _unhandled_input(event: InputEvent) -> void:
	print_debug("hii")
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_dialogue_balloon(load("res://dialogue/whale1.dialogue"), "intro")
		return
