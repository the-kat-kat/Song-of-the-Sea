extends Node2D

@export var marker_pos:Vector2
@export var rotate: float
@onready var marker = $ExitNode
@onready var tunnel_area = $TunnelArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	marker.position = marker_pos
	tunnel_area.rotate = rotate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
