extends StaticBody2D

@export var mainTileMap: TileMapLayer
@export var CollisionTileMap: TileMapLayer
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move(direction: Vector2):
	var pos = global_position
	var current_tile: Vector2i = mainTileMap.local_to_map(global_position)
	
	var target_tile: Vector2i =  Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	
	var mainTileData: TileData = mainTileMap.get_cell_tile_data(target_tile)
	var collisionData: TileData = CollisionTileMap.get_cell_tile_data(target_tile)
	if mainTileData == null or mainTileData.get_custom_data("walkable") == false :
		return
	if collisionData != null and collisionData.get_custom_data("collision") == true:
		return
	else:
		for i in 15:
			var target_tile_trans: Vector2i = Vector2i(
				current_tile.x + direction.x,
				current_tile.y + direction.y
			)
			global_position = mainTileMap.map_to_local(target_tile_trans)
			current_tile = target_tile_trans
			await get_tree().create_timer(0.03).timeout
		i = 0
