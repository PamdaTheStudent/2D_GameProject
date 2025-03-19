extends TileMapLayer

var entered = 0

func _ready() -> void:
	collision_enabled = false

func _on_end_body_entered(body: player) -> void:
	collision_enabled = true
	
