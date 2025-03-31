extends Area2D

var entered = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if entered == 0:
		entered = 1
	elif entered == 1 && body.is_in_group("player"):
		TransitionScreen.transition("fade_to_black_long")
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
