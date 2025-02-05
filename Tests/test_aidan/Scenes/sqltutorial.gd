extends Control
var database : SQLite

# Called when the node enters the scene tree for the first time.
func _ready():
	database = SQLite.new()
	database.path="res://boxes.db"
	database.open_db()
	database.select_rows("npc","level = 1",["*"])
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
