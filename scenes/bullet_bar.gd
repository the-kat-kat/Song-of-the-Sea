extends ProgressBar


var sb: StyleBoxFlat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sb = get_theme_stylebox("fill")
	value = 3
	sb.bg_color = Color("#91ffcf")
	
	GameManager.connect("player_set", Callable(self, "_on_player_set"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	value = GameManager.player.shoot_timer / GameManager.player.shoot_delay * 100
	
	if GameManager.player.shoots_left == 3:
		sb.bg_color = Color("#91ffcf")
	elif GameManager.player.shoots_left == 2:
		sb.bg_color = Color("#41ffea")
	elif GameManager.player.shoots_left == 1:
		sb.bg_color = Color("#00e7fa")
	else:
		sb.bg_color = Color("#71cdff")
