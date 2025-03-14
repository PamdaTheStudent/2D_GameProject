extends TileMapLayer

var entered = 0

func _ready() -> void:
	collision_enabled = false

func _on_end_body_entered(body: Node2D) -> void:
	if entered == 0:
		entered = 1
	elif entered == 1:
		collision_enabled = true
