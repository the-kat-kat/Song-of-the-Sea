extends AudioStreamPlayer2D

@onready var player = get_tree().get_nodes_in_group("player")[0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	print_debug("audio", global_position)
	print("ready: stream_set:", stream != null, "is_playing:", is_playing(), "volume_db:", volume_db, "bus:", bus)
	_print_bus_info()
	_find_listeners()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		print("distance", global_position - player.global_position)
		print("player", player.global_position)
		
func _print_bus_info():
	if bus == "":
		print("node bus is empty; using Master")
		return
	var bus_idx = -1
	if bus != "":
		bus_idx = AudioServer.get_bus_index(bus)
		if bus_idx >= 0:
			print("bus_idx:", bus_idx, "bus_volume_db:", AudioServer.get_bus_volume_db(bus_idx))
		else:
			print("bus name not found:", bus)
	print("master volume_db:", AudioServer.get_bus_volume_db(0))

func _find_listeners():
	var listeners = []
	_recursive_find_listeners(get_tree().get_root(), listeners)
	if listeners.size() == 0:
		print("no AudioListener2D nodes found in scene tree")
	else:
		for l in listeners:
			# try to print position if node has global_position
			var pos = "no global_position"
			if "global_position" in l:
				pos = str(l.global_position)
			print("found listener:", l.name, "pos:", pos, "owner:", l.owner)
	print("done scanning for listeners")

func _recursive_find_listeners(node, out_array):
	for c in node.get_children():
		# safe type check
		if c is AudioListener2D:
			out_array.append(c)
		_recursive_find_listeners(c, out_array)
