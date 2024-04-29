extends Control

signal scene_changed(new_scene : String)

var caller : String = ""
var callee : String = ""

var addresses : Dictionary = {
	"Login" : "res://scenes/Login.tscn",
	"LoadSave" : "res://scenes/LoadSave.tscn",
	"Home" : "res://scenes/GameHome.tscn",
	"Setting" : "res://Scripts/Setting/Test.tscn",
	"Fight" : "res://battler/battler.tscn"
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func notify(sender : String, recipient : String):
	caller = sender
	callee = recipient
	
	var new_scene = callee
	if(new_scene == "Login" or new_scene == "Home" or new_scene == "Fight"):
		scene_changed.emit(new_scene)


func back():
	var node = addresses[caller]
	get_tree().change_scene_to_file(node)

func to_login():
	var node = addresses["Login"]
	get_tree().change_scene_to_file(node)

