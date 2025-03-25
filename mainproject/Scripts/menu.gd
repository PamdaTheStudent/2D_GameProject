extends Control

signal Paralyze
signal Free

var paused = false

var current_level = 0

func _ready():
	var button = $CanvasLayer/Button

func _input(event):
	if event.is_action_pressed("ui_cancel") && not paused:
		paused = true
		Paralyze.emit()
		$CanvasLayer.visible = true
	elif event.is_action_pressed("ui_cancel") && paused:
		paused = false
		Free.emit()
		$CanvasLayer.visible = false
	else:
		pass
		
func _on_button_pressed():
	paused = false
	Free.emit()
	$CanvasLayer.visible = false
		
