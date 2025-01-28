extends TileMapLayer

func _ready() -> void:
	collision_enabled = false

func _on_end_body_entered(body: player) -> void:
	if not collision_enabled:
		collision_enabled = true
