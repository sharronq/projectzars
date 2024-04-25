extends Control

var caller : String = ""
var callee : String = ""

var addresses : Dictionary = {
	"Login" : "res://scenes/Login.tscn",
	"LoadSave" : "res://scenes/LoadSave.tscn",
	"Home" : "res://scenes/GameHome.tscn",
	"Setting" : "res://Scripts/Setting/Test.tscn"
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


func back():
	var node = addresses[caller]
	get_tree().change_scene_to_file(node)

func login():
	var node = addresses["Login"]
	get_tree().change_scene_to_file(node)
