class_name moveableBox
extends StaticBody2D

@export var moveIndicator: AnimatedSprite2D
@export var mainTileMap: TileMapLayer
@export var CollisionTileMap: TileMapLayer

var indicator: bool
var current_tile: Vector2
var collidingIndicator: bool
var moving 
var animation_speed = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_tile = mainTileMap.local_to_map(global_position)
	global_position = mainTileMap.map_to_local(current_tile)


func move(direction: Vector2):
	current_tile = mainTileMap.local_to_map(global_position)
	
	var target_tile: Vector2i =  Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	if collidingIndicator == true:
		return
	var mainTileData: TileData = mainTileMap.get_cell_tile_data(target_tile)
	var collisionData: TileData = CollisionTileMap.get_cell_tile_data(target_tile)
	if mainTileData == null or mainTileData.get_custom_data("walkable") == false :
		return
	if collisionData != null and collisionData.get_custom_data("collision") == true:
		return
	else:
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + direction *  16, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		global_position = mainTileMap.map_to_local(target_tile)

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is moveableBox:
		collidingIndicator = true


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is moveableBox:
		collidingIndicator = false
	#moveIndicator._changeState("Empty")

		
	
func movementIndicator(direction: Vector2) :
	
	if not indicator:  # Only update if interacting
		moveIndicator._changeState("Empty")
		return
		
	if direction == Vector2.UP:
		moveIndicator.rotation_degrees = 0
	elif direction == Vector2.DOWN:
		moveIndicator.rotation_degrees = 180
	elif direction == Vector2.LEFT:
		moveIndicator.rotation_degrees = 270
	elif direction == Vector2.RIGHT:
		moveIndicator.rotation_degrees = 90
		
	var current_tile: Vector2i = mainTileMap.local_to_map(global_position)
	
	var target_tile: Vector2i =  Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	var mainTileData: TileData = mainTileMap.get_cell_tile_data(target_tile)
	var collisionData: TileData = CollisionTileMap.get_cell_tile_data(target_tile)
	if moving or indicator == false:
		moveIndicator._changeState("Empty")
	elif indicator == true:
		if mainTileData == null or mainTileData.get_custom_data("walkable") == false :
			moveIndicator._changeState("Stop")
		elif collisionData != null and collisionData.get_custom_data("collision") == true:
			moveIndicator._changeState("Stop")
		elif mainTileData != null or mainTileData.get_custom_data("walkable") == true :
			moveIndicator._changeState("Move")
		if collidingIndicator == true:
			moveIndicator._changeState("Stop")
	moveIndicator.global_position = mainTileMap.map_to_local(target_tile)
	

		
func changeIndicator(inArea: bool):
	indicator = inArea
	if not inArea:
		moveIndicator._changeState("Empty") # Clear indicator when player exits area
	
