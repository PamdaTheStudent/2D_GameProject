extends Area2D

var entered = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
		if area_entered:
			if Input.is_action_just_pressed("ui_accept"):
				Dialogic.start("timeline")
		elif area_exited:
			Dialogic.end_timeline()
