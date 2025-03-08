extends AnimatedSprite2D

var _state = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_changeState("Empty")

func _changeState(State: String):
	#Swap the state of the moveInidcator
	_state = State
		#Show the MoveIndicator
	var anim = self
	if _state == "Move":
		anim.play("Move")
		
	if _state == "Stop":
		anim.play("Stop")
		
	if _state == "Empty":
		anim.visible  = false
	else:
		anim.visible  = true
		
