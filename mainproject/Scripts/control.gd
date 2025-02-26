extends Control

var database :SQLite
var xSave : int
var ySave : int
var named : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://boxes.db"
	database.open_db()
	var save_nodes = get_tree().get_nodes_in_group("savable")
	database.delete_rows("block","*")
	for Node in save_nodes:
		named = Node.name
		xSave = Node.current_tile.x
		
		ySave = Node.current_tile.y
		var data = {"Name":named,"Level":1,"x":xSave,"y":ySave}
		database.insert_row("block",data)
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		
			
	pass
