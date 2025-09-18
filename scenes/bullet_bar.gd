extends ProgressBar

@onready var player = get_tree().get_nodes_in_group("player")[0]

var sb = StyleBoxFlat.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("p", player)
	value = 0
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ff0000")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = player.shoot_timer / player.shoot_delay * 100
	
	if player.shoots_left == 3:
		sb.bg_color = Color("525252")
	elif player.shoots_left == 2:
		sb.bg_color = Color("#828181")
	elif player.shoots_left == 1:
		sb.bg_color = Color("#b8b6b6")
	else:
		sb.bg_color = Color("#fcfcfc")
