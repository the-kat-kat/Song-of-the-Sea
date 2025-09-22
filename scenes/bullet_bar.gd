extends ProgressBar

@onready var player = get_tree().get_nodes_in_group("player")[0]

var sb: StyleBoxFlat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sb = get_theme_stylebox("fill")
	print("p", player)
	value = 0
	sb.bg_color = Color("#91ffcf")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = player.shoot_timer / player.shoot_delay * 100
	
	if player.shoots_left == 3:
		sb.bg_color = Color("#91ffcf")
	elif player.shoots_left == 2:
		sb.bg_color = Color("#41ffea")
	elif player.shoots_left == 1:
		sb.bg_color = Color("#00e7fa")
	else:
		sb.bg_color = Color("#71cdff")
