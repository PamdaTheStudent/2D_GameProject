extends Node2D

signal title_screen_exit
@onready var anim = $"title card"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("default")
	anim.show()
	$dark.show()
		

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		title_screen_exit.emit()
		anim.hide()
		$dark.hide()
