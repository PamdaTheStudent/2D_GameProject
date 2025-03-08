extends CharacterBody2D
@export var mod_timer: Timer



func _process(delta: float) -> void:
	if !mod_timer.time_left == 0:
		move_and_slide()

		
func move(speed: Vector2):
	mod_timer.start(0.25)
	print_debug(speed)
	velocity = speed


	
	
