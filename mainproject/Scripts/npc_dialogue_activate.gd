class_name npc_dialogue_activate
extends Area2D

var in_range = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && in_range:
			$CanvasLayer/DialogueBox.start("tutorialNPC")
			in_range = false

func _on_body_entered(body):
	if body is player:
		in_range = true

func _on_body_exited(body):
	if body is player:
		in_range = false
