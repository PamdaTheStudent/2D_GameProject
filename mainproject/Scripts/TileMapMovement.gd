class_name moveableBox
extends StaticBody2D

@export var moveIndicator: AnimatedSprite2D
@export var mainTileMap: TileMapLayer
@export var CollisionTileMap: TileMapLayer

signal Moving
signal Still

var indicator: bool
var current_tile: Vector2
var collidingIndicator: bool
var animation_speed = 3
var moving

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_tile = mainTileMap.local_to_map(global_position)
	global_position = mainTileMap.map_to_local(current_tile)


func move(direction: Vector2):
	Moving.emit()
	$AudioStreamPlayer2D.play()
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
		

	target_tile = isIce(direction)

	# Calculate the movement distance in pixels
	var target_position = mainTileMap.map_to_local(target_tile)
	var distance = global_position.distance_to(target_position)

	# Adjust animation speed based on distance
	var base_speed = 16  # Speed per tile (adjust as needed)
	var duration = distance / (base_speed * animation_speed)
	
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE)
	
	moving = true
	await tween.finished
	moving = false
	global_position = mainTileMap.map_to_local(target_tile)
	Still.emit()

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
	if indicator == false:
		moveIndicator._changeState("Empty")
	moveIndicator.global_position = mainTileMap.map_to_local(target_tile)
	
func changeIndicator(inArea: bool):
		indicator = inArea
	
func isIce(direction: Vector2):
	animation_speed = 3
	current_tile = mainTileMap.local_to_map(global_position)
	var target_tile: Vector2i =  Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y)
	var loop = true
	while loop:
		var mainTileData: TileData = mainTileMap.get_cell_tile_data(target_tile) 
		if mainTileData == null or !mainTileData.get_custom_data("ice"):
			
			loop = false
			print(target_tile)
			return target_tile
		else:
			
			target_tile =  Vector2i(
			target_tile.x + direction.x,
			target_tile.y + direction.y)
			print(target_tile)
		animation_speed = 5
		
		print(target_tile)
