class_name NPC

extends Area2D

var in_range = false
@onready var pause_menu = get_node("/root/Menu")

signal Talking
signal Free
signal Close

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && in_range && not pause_menu.paused:
			Talking.emit()
			$AudioStreamPlayer2D.play()
			$CanvasLayer/DialogueBox.start()
			in_range = false
	if pause_menu.paused:
		$CanvasLayer/DialogueBox.stop()
	

func _on_body_entered(body):
	if body is player:
		in_range = true
		Close.emit()

func _on_body_exited(body):
	if body is player:
		in_range = false
		Free.emit()

func _on_dialogue_box_dialogue_ended():
	if not pause_menu.paused:
		Free.emit()
		
func _input(event):
	if event.is_action_pressed("ui_cancel") && not pause_menu.paused:
		Free.emit()
