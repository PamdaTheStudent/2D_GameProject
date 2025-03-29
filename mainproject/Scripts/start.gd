extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("start body entered")
		TransitionScreen.transition("fade_to_normal_long")
