extends Area2D

@onready var animation_player = $AnimationPlayer

var entered = 0

func _on_body_entered(body: Node2D) -> void:
	if entered == 0:
		entered = 1
	elif entered == 1:
		entered = 2
		animation_player.play("block_appear")
	


func _on_start_body_entered(body: Node2D) -> void:
	animation_player.play("block_disappear")
