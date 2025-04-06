extends Node2D

@onready var music = get_node("/root/Music")


# Called when the node enters the scene tree for the first time.
func _ready():
	if music.puzzle_theme.is_playing():
		music.puzzle_theme.stop()
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
