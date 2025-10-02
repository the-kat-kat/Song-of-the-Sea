extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var shield_sprite = $Sprite2D
@onready var shield_collision = $CollisionPolygon2D

func _ready() -> void:
	position.y = -50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(player.playerAnim.flip_h):
		shield_sprite.flip_h = true
		shield_sprite.position.x = -16
		shield_collision.scale.x = -1
		print("shield flip", shield_sprite.scale.x)
	else:
		shield_sprite.flip_h = false
		shield_sprite.position.x = 16
		shield_collision.scale.x = 1
