extends Button

# Dictionary keeps track of scene names and their next scene
# Key: current scene; Value: next scene
var scene_dict = {
	"Login": "res://scenes/LoadSave.tscn",
	"LoadSave": "res://scenes/GameHome.tscn",
	"Characters": "res://scenes/CharacterCollection.tscn",
	"Gamehome": "res://scenes/GameHome.tscn"
}

func initialize_button():
	if get_tree().get_current_scene().name == "Gamehome":
		self.disabled = true

# Called when button is pressed, transitions to new scene
func button_pressed():
	var path = get_scene_path()
	get_tree().change_scene_to_file(path)

# Gets the path to the next scene from the dictionary
func get_scene_path():
	var scene = get_tree().get_current_scene().name
	return scene_dict[scene]

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_button()
	self.pressed.connect(self.button_pressed) # Checks if button is pressed
											  # and calls function when it is pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
