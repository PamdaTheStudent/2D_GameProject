class_name player
extends CharacterBody2D
@export var InteractionBox : Area2D

# This enum lists all the possible states the character can be in.
enum States {IDLE, WALKING, PUSHING, CLIMBING, TALKING}

# This variable keeps track of the character's current state.
var state: States = States.IDLE

var speed = 50
var current_dir = "none"

var currVelocity : Vector2
var _indicatorReady
var targetBox
var moving
var movingObject = false
var previousDir = "none"


func _ready():
	_NPC_focus()
	$AnimatedSprite2D.play("idle_down")

func _NPC_focus():
	var NPC_Cast = [
		get_node("../NPC_0/Area2D"), 
		get_node("../NPC_1/Area2D"), 
		get_node("../NPC_2/Area2D"), 
		get_node("../NPC_3/Area2D"),
		get_node("../NPC_4/Area2D")
	]
	if NPC_Cast:
		for item in NPC_Cast.size():
			if NPC_Cast[item]:
				NPC_Cast[item].connect("Talking", Callable(self, "_talking"))
				NPC_Cast[item].connect("Free", Callable(self, "_dialogue_end"))

func _talking():
	speed = 0

func _dialogue_end():
	speed = 50

func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_just_pressed("ui_accept"):
		handle_collisions()
		movingObject = true
		await get_tree().create_timer(0.5).timeout
		movingObject = false
		
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
		state = States.WALKING
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
	if movingObject == true:
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
	if current_dir == "up":
		return Vector2.UP
	if current_dir == "down":
		return Vector2.DOWN
	if current_dir == "left":
		return Vector2.LEFT
	if current_dir == "right":
		return Vector2.RIGHT
