extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("stand")

func _process(delta: float) -> void:
	pass

func _on_area_2d_talking() -> void:
	$AnimatedSprite2D.play("talk")


func _on_area_2d_free() -> void:
	$AnimatedSprite2D.play("stand")


func _on_area_2d_close() -> void:
	$AnimatedSprite2D.play("approach")
