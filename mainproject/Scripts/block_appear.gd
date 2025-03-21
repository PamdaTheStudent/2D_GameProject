extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _on_end_body_entered(body: Node2D) -> void:
	animation_player.play("block_appear")
	print_debug("animation played")
