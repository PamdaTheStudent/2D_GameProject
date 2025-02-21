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
		$Sprite2D.texture = load('res://Sprites/GreenTransparent.png')
		if (Solution == false):
			Solution = true
			Activated.emit()

func _on_area_exited(area):
	if area is BlockPressure:
		$Sprite2D.texture = load('res://Sprites/RedTransparent.png')
		Solution = false
		Deactivated.emit()
