extends CanvasLayer

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

var progress_speed: float = 100.0
var done: bool = false

func _ready() -> void:
	progress_bar.value = 0
	label.text = "Loading"
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if done:
		return
	progress_bar.value += progress_speed * delta
	if progress_bar.value >= 100:
		progress_bar.value = 100
		done = true
		label.text = "Done Loading!"
