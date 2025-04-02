class_name theDoor
extends Area2D

var open:bool = false

signal OPEN

# Called when the node enters the scene tree for the first time.
func _ready():
	var plate = get_node("../PressurePlate")
	if plate:
		print("plate")
		plate.connect("Activated", Callable(self, "_on_activated"))
		plate.connect("Deactivated", Callable(self, "_on_deactivated"))

func _on_activated():
	open = true
	print("Activated!")

func _on_deactivated():
	open = false
	print("Deactivated!")

func _on_body_entered(body: Node2D):
	if open && body.is_in_group("player"):
		print("Entered!")
		OPEN.emit()
	
