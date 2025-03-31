extends Area2D

@onready var animation_player = $AnimationPlayer

var entered = false

func _on_body_entered(body: Node2D) -> void:
	if not entered && body.is_in_group("player"):
		animation_player.play("block_appear")
		entered = true
	
func _on_start_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play("block_disappear")
