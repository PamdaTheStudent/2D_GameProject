class_name theDoor
extends Area2D

var open:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var plate = get_node("../PressurePlate")
	if plate:
		plate.connect("Activated", Callable(self, "_on_activated"))
		plate.connect("Deactivated", Callable(self, "_on_deactivated"))

func _on_activated():
	$Sprite2D.texture = load('res://Sprites/tilesets/grass.png')
	open = true
	print("Activated!")

func _on_deactivated():
	$Sprite2D.texture = load('res://Sprites/GreenTransparent.png')
	open = false
	print("Deactivated!")

func _on_body_entered(body):
	if open && body is player:
		$Sprite2D.texture = load('res://Sprites/PinkTransparent.png')
		print("Entered!")
		get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
