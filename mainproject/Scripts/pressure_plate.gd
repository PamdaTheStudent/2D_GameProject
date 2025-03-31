class_name pressurePlate
extends Area2D

var Solution = false
signal Activated
signal Deactivated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_entered(area):
	if area is BlockPressure:
		if (Solution == false):
			Solution = true
			Activated.emit()

func _on_area_exited(area):
	if area is BlockPressure:
		Solution = false
		Deactivated.emit()
