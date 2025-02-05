class_name moveableBox
extends StaticBody2D

@export var moveIndicator: AnimatedSprite2D
@export var mainTileMap: TileMapLayer
@export var CollisionTileMap: TileMapLayer

var indicator: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_tile: Vector2i = mainTileMap.local_to_map(global_position)
	global_position = mainTileMap.map_to_local(current_tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func move(direction: Vector2):
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
		
		global_position = mainTileMap.map_to_local(target_tile)
		
	
func movementIndicator(direction: Vector2) :
	if direction == Vector2.UP:
		moveIndicator.rotation_degrees = 0
	if direction == Vector2.DOWN:
		moveIndicator.rotation_degrees = 180
	if direction == Vector2.LEFT:
		moveIndicator.rotation_degrees = 270
	if direction == Vector2.RIGHT:
		moveIndicator.rotation_degrees = 90
	var current_tile: Vector2i = mainTileMap.local_to_map(global_position)
	
	var target_tile: Vector2i =  Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	var mainTileData: TileData = mainTileMap.get_cell_tile_data(target_tile)
	var collisionData: TileData = CollisionTileMap.get_cell_tile_data(target_tile)
	if indicator == true:
		if mainTileData == null or mainTileData.get_custom_data("walkable") == false :
			moveIndicator._changeState("Stop")
		elif collisionData != null and collisionData.get_custom_data("collision") == true:
			moveIndicator._changeState("Stop")
		elif mainTileData != null or mainTileData.get_custom_data("walkable") == true :
			moveIndicator._changeState("Move")
	if indicator == false:
		moveIndicator._changeState("Empty")
	moveIndicator.global_position = mainTileMap.map_to_local(target_tile)
	
func changeIndicator(inArea: bool):
		indicator = inArea

#func addCollsionToTile():
	#current_tile
