extends CharacterBody2D


const speed = 100
var current_dir = "none"
var push_force = 300
func _ready():
	$AnimatedSprite2D.play("idle_down")
func _physics_process(delta):
	player_movement(delta)
	handle_collisions()
					
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0	
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"		
		play_anim(1)		
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)		
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
func handle_collisions():
	# Process collisions after movement
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			# Apply the push force
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			if current_dir == "down":
				# Separate player slightly from the box to prevent sliding
				var separation_vector = c.get_normal() * 1  # Adjust as needed
				global_position += separation_vector
			
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	match dir:
		"right":
			anim.flip_h = false			
			if movement == 1:
				anim.play("walk_side")
			elif movement == 0:
				anim.play("idle_side")
		"left":
			anim.flip_h = true
			if movement == 1:
				anim.play("walk_side")
			elif movement == 0:
				anim.play("idle_side")
		"up":
			anim.flip_h = true	
			if movement == 1:
				anim.play("walk_up")
			elif movement == 0:
				anim.play("idle_up")
		"down":
			anim.flip_h = true	
			if movement == 1:
				anim.play("walk_down")
			elif movement == 0:
				anim.play("idle_down")


