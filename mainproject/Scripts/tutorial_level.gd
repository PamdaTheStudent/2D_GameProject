extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var pause_menu = get_node("/root/Menu/CanvasLayer/Button")
	
	pause_menu.text = "Begin"
