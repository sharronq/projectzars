extends Button

# Dictionary keeps track of scene names and their next scene
# Key: current scene; Value: next scene
var scene_dict = {
	"LoadSave": "res://scenes/GameHome.tscn",
	"Characters": "res://scenes/CharacterCollection.tscn",
	"Gamehome": "res://scenes/GameHome.tscn"
}

func initialize_button():
	if get_tree().get_current_scene().name == "Gamehome":
		self.disabled = true

# Called when button is pressed, transitions to new scene
func button_pressed():
	var current_tree = get_tree()
	if current_tree == null:
		return
	elif current_tree.get_current_scene().name not in scene_dict:
		print("Scene not found")
		return
	var path = scene_dict[current_tree.get_current_scene().name]
	get_tree().change_scene_to_file(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_button()
	self.pressed.connect(self.button_pressed) # Checks if button is pressed
											  # and calls function when it is pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

