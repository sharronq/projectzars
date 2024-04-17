extends Node2D

#The number of game slot
var game_version : int
#mode between loading or saving file
var load_save : String
#index file
var user_file : Dictionary

@onready var saveload_label = $"../LoadSave/save load text"

# Dictionary keeps track of scene names and their next scene
# Key: current scene; Value: next scene
var scene_dict = {
	"LoadSave": "res://scenes/GameHome.tscn",
	"Characters": "res://scenes/CharacterCollection.tscn",
	"Gamehome": "res://scenes/GameHome.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_button()
	var found = SaveLoadManager.check_currentFight_exist()
	
#Initialize the index file (database)
	SaveLoadManager.load_successful.connect(load_successed)
	SaveLoadManager.save_successful.connect(save_successed)
	
	game_version = -1
	load_save = "load"
	user_file = SaveLoadManager.get_index_file()


func initialize_button():
	if get_scene_name() == "Gamehome" && self.text == "Home":
		self.disabled = true
	if get_scene_name() == "Viewcharacters" && self.text == "View characters":
		self.disabled = true

func get_scene_name():
	return get_tree().get_current_scene().name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Called when load button is pressed, transitions to new scene
func _on_load_1_pressed():
	#get_tree().change_scene_to_file("res://scenes/GameHome.tscn")
	#return
	print("delete, load")
	load_save = "load"

func _on_save_pressed():
	print("delete, save")
	load_save = "save"
	
func _on_slot_1_pressed():
	game_version = 1
	if load_save == "load":
		saveload_label.text = "Loading: Slot 1"
	elif load_save == "save":
		saveload_label.text = "Saving to: Slot 1"
	
func _on_slot_2_pressed():
	game_version = 2
	if load_save == "load":
		saveload_label.text = "Loading: Slot 2"
	elif load_save == "save":
		saveload_label.text = "Saving to: Slot 2"

func _on_slot_3_pressed():
	game_version = 3
	if load_save == "load":
		saveload_label.text = "Loading: Slot 3"
	elif load_save == "save":
		saveload_label.text = "Saving to: Slot 3"

#central control of actual loading or saving file
func _on_comfirm_pressed():
	#If no game slot is being selected, prompt the user to select one
	if(game_version == -1):
		print("Print a message")
		saveload_label.text = "Please select a game slot."
		return

	if(load_save == "save"):
		SaveLoadManager.Save(game_version)
	
	else:
		#Load the game from Firebase
		SaveLoadManager.Load(game_version)

#Return function by SaveLoadManager.Load()
#When finish initialize the actual game content from Firebase, direct user to home page
func load_successed():
	var path = scene_dict[get_scene_name()]
	get_tree().change_scene_to_file(path)

func save_successed():
	#After save the current game, update the slot information
	print("Print a message")
	pass



