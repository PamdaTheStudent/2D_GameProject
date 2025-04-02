extends Node

@onready var puzzle_theme = $AudioStreamPlayer

var time_to_play = true

func _play_music():
	if time_to_play == true:
		puzzle_theme.play()
		await get_tree().create_timer(140).timeout
		puzzle_theme.play()
		time_to_play = false
	elif time_to_play == false:
		puzzle_theme.stop()
		time_to_play = true
