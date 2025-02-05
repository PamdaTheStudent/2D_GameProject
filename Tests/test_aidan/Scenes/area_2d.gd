extends Area2D

var here=false
var database : SQLite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path="res://boxes.db"
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var database: SQLite
	if true:
		if true && Input.is_action_just_pressed("ui_accept"):
			database.open_db()
			var x = database.select_rows("NPC","Level=1",["Dialogue"])
			Dialogic.start(x)
			here = true
	elif area_exited:
		Dialogic.end_timeline()
		here = false
		
		
