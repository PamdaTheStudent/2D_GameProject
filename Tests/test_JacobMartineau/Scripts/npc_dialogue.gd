class_name NPC

extends Area2D

var in_range = false

signal Talking
signal Free
signal Close

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && in_range:
			Talking.emit()
			
			$CanvasLayer/DialogueBox.start()
			in_range = false

func _on_body_entered(body):
	if body is player:
		in_range = true
		Close.emit()

func _on_body_exited(body):
	if body is player:
		in_range = false
		Free.emit()

func _on_dialogue_box_dialogue_ended():
	Free.emit()
