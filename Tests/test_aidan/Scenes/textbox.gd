extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

var text_queue = []

enum State {READY, FINISHED}

var current_state = State.READY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()
	queue_text("first")
	queue_text("second")
	queue_text("third")
	queue_text("fourth")
	queue_text("fifth")

func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)

func queue_text(next_text):
	text_queue.push_back(next_text)
	match current_state:
		State.READY:
			pass
		State.FINISHED:
			pass
		

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = ">"
	end_symbol.text = "<"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.FINISHED)
	show_textbox()
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
	
