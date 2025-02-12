extends Node2D

@export var collisionInterface : Area2D
@onready var coll : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func checkCollision(Position:Vector2):
	collisionInterface.position = Position
	if collisionInterface.bodyCollision:
		
		return true
	else:
		return false
