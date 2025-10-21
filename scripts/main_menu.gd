extends CanvasLayer

var button_num = 0

@onready var b1: Button = $Control/Play
@onready var b2: Button = $Control/Settings
@onready var arrow: Label = $Label

func _ready():
	b1.focus_mode = Control.FOCUS_NONE
	b2.focus_mode = Control.FOCUS_NONE
	arrow.global_position = b1.global_position + Vector2(-20, 20)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		button_num = (button_num +1) %2
		update_arrow_position()
	elif Input.is_action_just_pressed("proceed"):
		print("proceed")
		if button_num == 0:
			# go to level 0
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		elif button_num ==1:
			# go to settings
			get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")

func update_arrow_position():
	var target_button
	if button_num == 1:
		target_button = b2
	else:
		target_button = b1
		
	var target_pos = target_button.global_position + Vector2(-20, 20)
	var tween = create_tween()
	tween.tween_property(arrow, "global_position", target_pos, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")
