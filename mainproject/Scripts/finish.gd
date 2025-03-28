extends Area2D

var entered = 0

@onready var pause_menu = get_node("/root/Menu")

func _on_body_entered(body: Node2D) -> void:
	if entered == 0:
		entered = 1
	elif entered == 1:
		TransitionScreen.transition("fade_to_black_long")
		await TransitionScreen.on_transition_finished
		pause_menu.current_level += 1

		match pause_menu.current_level:
			1: get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
			2: get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
			3: get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
			_: print("You won!")
		
