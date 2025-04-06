extends Area2D

@onready var pause_menu = get_node("/root/Menu")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		TransitionScreen.transition("fade_to_black_long")
		await TransitionScreen.on_transition_finished
		pause_menu.current_level += 1

		match pause_menu.current_level:
			1: get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
			2: get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
			3: get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")
			_: get_tree().change_scene_to_file("res://Scenes/Levels/outside.tscn")
		
