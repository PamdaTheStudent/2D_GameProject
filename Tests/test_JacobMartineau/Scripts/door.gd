class_name theDoor
extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var plate = get_node("../PressurePlate")
	if plate:
		plate.connect("Activated", Callable(self, "_on_activated"))
		plate.connect("Deactivated", Callable(self, "_on_deactivated"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_activated():
	$Sprite2D.texture = load('res://Sprites/tilesets/grass.png')
	print("Activated!")

func _on_deactivated():
	$Sprite2D.texture = load('res://Sprites/GreenTransparent.png')
	print("Deactivated!")
