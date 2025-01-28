extends Control

var database :SQLite
var xSave : int
var ySave : int
var named : String
#C alled when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://boxes.db"
	database.open_db()
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("save"):
		var save_nodes = get_tree().get_nodes_in_group("save_node")
		database.delete_rows("block","")
		for Node in save_nodes:
			named = Node.name
			if Node is player: 
				xSave = Node.position.x
				ySave = Node.position.y
			elif Node is moveableBox:
				print(named)
				xSave = Node.current_tile.x
				ySave = Node.current_tile.y
			else: continue
		var data = {"Name":named,"Level":1,"x":xSave,"y":ySave}
		database.insert_row("block",data)

	if Input.is_action_just_pressed("load"):

		database.select_rows("block","name='player'",[""])

		database.select_rows("block","name!='player'",["*"])
	pass
