extends Button

# Dictionary keeps track of scene names and their next scene
# Key: current scene; Value: next scene
var scene_dict = {
	"LoadSave": "res://scenes/GameHome.tscn",
	"Characters": "res://scenes/CharacterCollection.tscn",
	"Gamehome": "res://scenes/GameHome.tscn"
}

func initialize_button():
	if get_scene_name() == "Gamehome" && self.text == "Home":
		self.disabled = true
	if get_scene_name() == "Viewcharacters" && self.text == "View characters":
		self.disabled = true

# Called when button is pressed, transitions to new scene
func button_pressed():
	if get_tree() == null:
		return
	elif get_scene_name() not in scene_dict:
		print("Scene not found")
		return
	var path = scene_dict[get_scene_name()]
	get_tree().change_scene_to_file(path)

func get_scene_name():
	return get_tree().get_current_scene().name

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_button()
	self.pressed.connect(self.button_pressed) # Checks if button is pressed
											  # and calls function when it is pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

