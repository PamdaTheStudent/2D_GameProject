extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func move(speed: Vector2):
	print_debug(speed)
	global_position += speed
