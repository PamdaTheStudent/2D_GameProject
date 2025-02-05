extends Area2D

var here=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if area_entered:
		if here == false && Input.is_action_just_pressed("ui_accept"):
			Dialogic.start("timeline")
			here = true
	elif area_exited:
		Dialogic.end_timeline()
		here = false
