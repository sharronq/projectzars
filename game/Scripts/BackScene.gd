# THIS SCRIPT IS FOR "BACK" OR "QUIT" BUTTONS

extends Button

var scene_dict = {
	"LoadSave": "res://scenes/Login.tscn",
	"MainMenu": "res://scenes/LoadSave.tscn"
}

func button_pressed():
	SceneSwitcher.back()

func get_scene_path():
	var scene = get_tree().get_current_scene().name
	return scene_dict[scene]

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self.button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
