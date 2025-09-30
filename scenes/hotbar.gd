extends HBoxContainer


signal equip(item: Item)

var currently_equipped: Item:
	set(value):
		currently_equipped = value
		equip.emit(value)
		
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
	var rect = child.get_global_rect()
	rect.position = child.position
	
	var margin = 6.0
	rect.position -= Vector2(margin, margin)
	rect.size += Vector2(margin * 2.0, margin * 2.0)
	
	draw_rect(rect, Color.WHITE, false, 3) 
	
func _input(event):
	if Input.is_action_just_pressed("q"):
		if(index == get_child_count() - 1):
			index = 0
		else:
			index += 1
		print(index)
			
func update():
	currently_equipped = get_child(index).item

func use_current():
	get_child(index).amount -= 1
