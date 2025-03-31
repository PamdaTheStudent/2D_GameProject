extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_enabled = true
	
func _on_door_open():
	collision_enabled = false
