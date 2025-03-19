extends Area2D

@onready var animation_player = $AnimationPlayer

var entered = 0

func _on_body_entered(body: player) -> void:
	animation_player.play("block_appear")
	
	


func _on_start_body_entered(body: Node2D) -> void:
	animation_player.play("block_disappear")
