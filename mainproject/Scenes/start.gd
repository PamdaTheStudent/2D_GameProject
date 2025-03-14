extends Area2D

var entered = 0

func _on_body_entered(body: Node2D) -> void:
	if entered == 0:
		entered = 1
	elif entered == 1:
		TransitionScreen._on_transition_finished("fade_to_normal")
