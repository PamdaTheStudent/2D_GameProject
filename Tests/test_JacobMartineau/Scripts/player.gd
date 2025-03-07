class_name player
extends CharacterBody2D
@export var InteractionBox : Area2D

const speed = 200
var current_dir = "none"

var currVelocity : Vector2
var _indicatorReady
var targetBox
var cutscene = 0

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_just_pressed("ui_accept"):
		handle_collisions()
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
		
		 
	elif Input.is_action_pressed("ui_up") or cutscene > 1:
		InteractionBox.rotation_degrees = 270
		current_dir = "up"		
		velocity.x = 0
		velocity.y = -speed
		
	
	else:
		play_anim(0)		
		velocity.x = 0
		velocity.y = 0
		
	
	currVelocity = velocity
	if (velocity.x != 0 or velocity.y != 0): 
		play_anim(1)
		move_and_slide()
	
	
	
func handle_collisions():
	if _indicatorReady:
		targetBox.move(directionToVector2())

			
	
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	match dir:
		"right":
			anim.flip_h = false			
			if movement == 1:
				anim.play("walk-right")
			elif movement == 0:
				anim.play("idle")
		"left":
			anim.flip_h = false
			if movement == 1:
				anim.play("walk-left")
			elif movement == 0:
				anim.play("idle")
		"up":
			anim.flip_h = true	
			if movement == 1:
				anim.play("walk-back")
			elif movement == 0:
				anim.play("idle")
		"down":
			anim.flip_h = true	
			if movement == 1:
				anim.play("walk-forward")
			elif movement == 0:
				anim.play("idle")



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
	if current_dir == "up":
		return Vector2.UP
	if current_dir == "down":
		return Vector2.DOWN
	if current_dir == "left":
		return Vector2.LEFT
	if current_dir == "right":
		return Vector2.RIGHT


func _on_finish_body_entered(body: Node2D) -> void:
	print_debug("body entered")
	cutscene += 1
