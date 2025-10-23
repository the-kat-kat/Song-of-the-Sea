extends HBoxContainer

@onready var outline = get_parent().get_node("Outline")

var shield_path = preload("res://scenes/player/shield.tscn")
var dagger_path = preload("res://scenes/player/dagger.tscn")

@export var shield_time = 3.0

var currently_equipped: Item:
	set(value):
		currently_equipped = value
		
var index = 0:
	set(value):
		index = value
		
		if index >= get_child_count():
			index = 0
		elif index <0:
			index = get_child_count() - 1
		
		currently_equipped = get_child(index).item
		queue_redraw()
		
func _ready():
	call_deferred("queue_redraw")
	
func _draw():
	if get_child_count() == 0:
		return
	var child = get_child(index)
	outline.global_position = child.global_position + Vector2(-7.5, -7.5)
	
func _input(event):
	if Input.is_action_just_pressed("q"):
		if(index == get_child_count() - 1):
			index = 0
		else:
			index += 1
		print(index)
	
	if Input.is_action_just_pressed("fire"):
		use_current()
		
func update():
	currently_equipped = get_child(index).item

func use_current():
	if currently_equipped == null || currently_equipped.title =="default":
		GameManager.player.fire()
		return
		
	if get_child(index).amount>0:
		get_child(index).amount -= 1
		match currently_equipped.title:
			"shield":
				var new_shield = shield_path.instantiate()
				GameManager.player.add_child(new_shield)
				await get_tree().create_timer(shield_time).timeout
				new_shield.queue_free()
			"dagger":
				var new_dagger = dagger_path.instantiate()
				GameManager.player.add_child(new_dagger)
				if !GameManager.player.playerAnim.flip_h:
					new_dagger.position.x = 300
					new_dagger.direction = Vector2(1,0)
				else:
					new_dagger.position.x = -300
					new_dagger.direction = Vector2(-1,0)
				new_dagger.shoot()
			_:
				print("unexpected ce title:", currently_equipped.title)
				
		if get_child(index).amount <= 0:
			get_child(index).item = null
			index -=1
