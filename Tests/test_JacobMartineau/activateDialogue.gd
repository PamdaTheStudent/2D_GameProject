extends Area2D

@onready var dialogue_box = $DialogueBox

func _on_body_entered(body):
	if body is player:
		dialogue_box.start()
