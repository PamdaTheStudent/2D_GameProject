extends TileMapLayer

func _ready() -> void:
	collision_enabled = false

func _on_end_body_entered(body: Node2D) -> void:
	if not collision_enabled && body.is_in_group("player"):
		collision_enabled = true
