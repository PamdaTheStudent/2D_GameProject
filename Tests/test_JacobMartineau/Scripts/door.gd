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
	print("Activated!")

func _on_deactivated():
	print("Deactivated!")
