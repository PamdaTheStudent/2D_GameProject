extends Area2D

var here = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if here == false && Input.is_action_just_pressed("ui_accept"):
			Dialogic.start("timeline")
			here = true


func _on_body_exited(body: Node2D) -> void:
	here == false
	Dialogic.end_timeline()
