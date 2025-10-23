extends StaticBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var shield_sprite = $Sprite2D
@onready var shield_collision = $CollisionPolygon2D

func _ready() -> void:
	position.y = -50
	shield_collision.disabled = true
	scale = Vector2(0.1, 0.1)
	
	var tween = create_tween()
	tween.tween_callback(func(): shield_collision.disabled = false)
	tween.tween_property(self, "scale", Vector2.ONE*15, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(player.playerAnim.flip_h):
		shield_sprite.flip_h = true
		shield_sprite.position.x = -16
		shield_collision.scale.x = -1
	else:
		shield_sprite.flip_h = false
		shield_sprite.position.x = 16
		shield_collision.scale.x = 1
