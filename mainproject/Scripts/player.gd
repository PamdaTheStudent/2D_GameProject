class_name player
extends CharacterBody2D
@export var InteractionBox : Area2D
@onready var anim = $AnimatedSprite2D
@onready var pause_menu = get_node("/root/Menu")

var speed = 200
var current_dir = "none"

var currVelocity : Vector2
var _indicatorReady
var targetBox
var can_move_boxes = true
var cutscene = 0 # Why not use a bool?
var talking = false

# This enum lists all the possible states the character can be in.
enum States {ACTIVE, PASSIVE}

# This variable keeps track of the character's current state.
var state: States = States.ACTIVE

# READY AND PHYSICS

func _ready():
	_activate_menu()
	_NPC_focus()
	if pause_menu.current_level > 3:
		$AnimatedSprite2D.play("paused")
	else:
		$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if state == States.ACTIVE:
		can_move_boxes = true
		speed = 200
	elif state == States.PASSIVE:
		can_move_boxes = false
		speed = 0
	player_movement(delta)
	if Input.is_action_just_pressed("ui_accept") && can_move_boxes:
		handle_collisions()
	if _indicatorReady == true:
		CheckTargetTile(targetBox)

# MOVEMENT

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
	elif Input.is_action_pressed("ui_up") or cutscene == 1:
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

func play_anim(movement):
	if state == States.ACTIVE:
		var footstep = $AudioStreamPlayer2D
		var dir = current_dir
		if movement == 0:
			footstep.play()
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

# BLOCK PUSHING

func handle_collisions():
	if _indicatorReady:
		targetBox.move(directionToVector2())

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

# NPCs

func _NPC_focus():
	var NPC_Cast = [
		get_node("../NPC_0/Area2D")
	]
	if NPC_Cast:
		for item in NPC_Cast.size():
			if NPC_Cast[item]:
				NPC_Cast[item].connect("Talking", Callable(self, "_talking"))
				NPC_Cast[item].connect("Free", Callable(self, "_dialogue_end"))

func _talking():
	talking = true
	state = States.PASSIVE

func _dialogue_end():
	talking = false
	state = States.ACTIVE

# EXITING LEVEL

func _on_finish_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("body entered")
		if cutscene == 0:
			cutscene = 1
		elif cutscene == 1:
			cutscene = 2


func _on_start_body_entered(body: Node2D) -> void:
	print_debug("body entered")
	if cutscene == 0:
		cutscene = 1


func _on_end_body_entered(body: Node2D) -> void:
	print_debug("body entered")
	if cutscene == 1:
		cutscene = 0

# MENU

func _activate_menu():
	var pause_menu = get_node("/root/Menu")
	pause_menu.connect("Paralyze", Callable(self, "_on_menu_paralyze"))
	pause_menu.connect("Free", Callable(self, "_on_menu_free"))
	
	
func _on_menu_paralyze():
	$AnimatedSprite2D.scale = Vector2(0.16, 0.16)
	anim.play("paused")
	state = States.PASSIVE
	
func _on_menu_free():
	$AnimatedSprite2D.scale = Vector2(0.286, 0.286)
	anim.play("idle")
	if not talking:
		state = States.ACTIVE


func _on_title_screen_ready() -> void:
	_on_menu_paralyze()


func _on_title_screen_title_screen_exit() -> void:
	await get_tree().create_timer(1.5).timeout
	_on_menu_free()
