extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $SubViewport.get_children():
		child.queue_free()
	var new_scene = load("res://scenes/level1_full.tscn").instantiate()
	$SubViewport.add_child(new_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
