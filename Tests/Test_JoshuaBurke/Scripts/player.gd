extends CharacterBody2D
@export var InteractionBox : Area2D

const speed = 100
var current_dir = "none"

var currVelocity : Vector2
var _indicatorReady
var targetBox
var moveingObject = false
var moving = false
var previousDir = "none"


func _ready():
	$AnimatedSprite2D.play("idle_down")
	
func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_just_pressed("ui_accept"):
		handle_collisions()
		moveingObject = true
		await get_tree().create_timer(0.5).timeout
		moveingObject = false
		
			
	if _indicatorReady == true:
		CheckTargetTile(targetBox)


	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		InteractionBox.rotation_degrees = 0
		current_dir = "right"
		#play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		InteractionBox.rotation_degrees = 180
		current_dir = "left"
		#play_anim(1)
		velocity.x = -speed
		velocity.y = 0	
	elif Input.is_action_pressed("ui_down"):
		InteractionBox.rotation_degrees = 90
		current_dir = "down"
		#play_anim(1)
		velocity.x = 0
		velocity.y = speed
		
		 
	elif Input.is_action_pressed("ui_up"):
		InteractionBox.rotation_degrees = 270
		current_dir = "up"		
		velocity.x = 0
		velocity.y = -speed
		
	
	else:
		play_anim(0)		
		velocity.x = 0
		velocity.y = 0
		moving = false
		
	
	currVelocity = velocity
	
	if previousDir != current_dir:
		if _indicatorReady:
			_indicatorReady = false
			targetBox.changeIndicator(_indicatorReady)
			CheckTargetTile(targetBox)
		previousDir = current_dir
		
		
	if (velocity.x != 0 or velocity.y != 0): 
		moving = true
		play_anim(1)
		move_and_slide()
	
	
	
func handle_collisions():
	if _indicatorReady:
		targetBox.move(directionToVector2())

			
	
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	var animation = "walk_side"
	
	if moving:
		match dir:
			"left":
				animation = "walk_side"
				anim.flip_h = true
				
			"right":
				animation = "walk_side"
				anim.flip_h = false			
				
			"up":
				animation = "walk_up"
				anim.flip_h = true	
				
			"down":
				animation = "walk_down"
				anim.flip_h = true	
			
	else:
		animation = "idle_down"
		#match dir:
			#"left":
				#animation = "idle_side"
				#anim.flip_h = true
				#
			#"right":
				#animation = "idle_side"
				#anim.flip_h = false			
				#
			#"up":
				#animation = "idle_up"
				#anim.flip_h = true	
				#
			#"down":
				#animation = "idle_down"
				#anim.flip_h = true	
	if moveingObject == true:
			animation = "move"

		
	anim.play(animation)



func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is moveableBox:
		_indicatorReady = true
		body.changeIndicator(_indicatorReady)
		targetBox = body
		
	
func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is moveableBox:
		_indicatorReady = false
		body.changeIndicator(_indicatorReady)
		CheckTargetTile(body)

	
func CheckTargetTile(body):
	body.movementIndicator(directionToVector2())


func directionToVector2():	
	var directions = {
		"up": Vector2.UP,
		"down": Vector2.DOWN,
		"left": Vector2.LEFT,
		"right": Vector2.RIGHT
	}
	return directions.get(current_dir, Vector2.ZERO)
