extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_black_long":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
		

func transition(anim_name):
	color_rect.visible = true
	if anim_name == "fade_to_black_long":
		animation_player.play("fade_to_black_long")
	elif anim_name == "fade_to_black":
		animation_player.play("fade_to_black")
	elif anim_name == "fade_to_normal_long":
		animation_player.play("fade_to_normal_long")
	elif anim_name == "fade_to_normal":
		animation_player.play("fade_to_normal")
	elif anim_name == "anim_off":
		color_rect.visible = false
