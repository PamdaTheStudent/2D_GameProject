extends Control

var database :SQLite
var xSave : int
var ySave : int
var named : String
var play : Array
var boxes : Array
#C alled when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://boxes.db"
	database.open_db()
	database.delete_rows("block", "")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		var save_nodes = get_tree().get_nodes_in_group("save_node")
		database.delete_rows("block","")
		for ode in save_nodes:
			named = ode.name
			if ode is player: 
				xSave = ode.position.x
				ySave = ode.position.y
				var data = {"Name":named,"Level":1,"x":xSave,"y":ySave}
				database.insert_row("block",data)
			elif ode is moveableBox:
				print(named)
				xSave = ode.position.x
				ySave = ode.position.y
				var data = {"Name":named,"Level":1,"x":xSave,"y":ySave}
				database.insert_row("block",data)
			else: continue

	if Input.is_action_just_pressed("load"):
		play = database.select_rows("block","",["Name","x","y"])
		for row in play:
			var xload = row.get("x")
			var yload = row.get("y")
			var target = row.get("Name")
			var node = get_tree().current_scene.find_child(target, true, false)
			node.position = Vector2(xload, yload)
	pass
			
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
