extends Node2D

#The number of game slot
var game_version : int
#mode between loading or saving file
var load_save : String
#index file
var user_file : Dictionary
#save slot user chooses
var save_slot = "1"

@onready var saveload_label = $saveload_label

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
	SaveLoadManager.delete_successful.connect(delete_successed)
	
	game_version = -1
	load_save = "load"
	user_file = SaveLoadManager.get_index_file()
	
	update_label()
	check_permission_save()
	
	$Slot1.grab_focus()

func initialize_button():
	if get_scene_name() == "Gamehome" && self.text == "Home":
		self.disabled = true
	if get_scene_name() == "Viewcharacters" && self.text == "View characters":
		self.disabled = true

func get_scene_name():
	return get_tree().get_current_scene().name

# Called when load button is pressed, transitions to new scene
func _on_load_1_pressed():
	#get_tree().change_scene_to_file("res://scenes/GameHome.tscn")
	#return
	load_save = "Load"
	$Pop_up/Announcement.text = "Load Save Slot " + save_slot + "? 
	* Any unsaved progress will be lost!"
	$Pop_up.show()
	$Pop_up/Yes.grab_focus()

func _on_save_pressed():
	load_save = "Save"
	$Pop_up/Announcement.text = "Save to Save Slot " + save_slot + "? 
	* Cannot be undone!"
	$Pop_up.show()
	$Pop_up/Yes.grab_focus()
 
func _on_delete_pressed():
	load_save = "Delete"
	$Pop_up.show()
	$Pop_up/No.grab_focus()

func _on_slot_1_pressed():
	save_slot = "1"
	$Load.grab_focus()

func _on_slot_2_pressed():
	save_slot = "2"
	$Load.grab_focus()

func _on_slot_3_pressed():
	save_slot = "3"
	$Load.grab_focus()






#Return function by SaveLoadManager.Load()
#When finish initialize the actual game content from Firebase, direct user to home page
func load_successed():
	SceneSwitcher.notify("Save", "Home")
	Settings.load_user_data()
	$Pop_up.hide()
	var path = "res://scenes/GameHome.tscn"
	get_tree().change_scene_to_file(path)

func save_successed():
	#After save the current game, update the slot information
	update_label()
	$Pop_up.hide()
	$Slot1.grab_focus()

func delete_successed():
	update_label()
	$Pop_up.hide()
	$Slot1.grab_focus()

func update_label():
	for i in range(1, 4):
		var game_save = "Slot" + str(i)
		get_node(game_save).update_label(i)



func _on_yes_pressed():
	#If no game slot is being selected, prompt the user to select one
	if(game_version == -1):
		print("Print a message")
		saveload_label.text = "Please select a game slot."
		return

	if(load_save == "Save"):
		await SaveLoadManager.Save(game_version)

	elif(load_save == "Delete"):
		SaveLoadManager.delete_index_file(game_version)
	else:
		#Load the game from Firebase
		SaveLoadManager.Load(game_version)


func _on_no_pressed():
	$Pop_up.hide()
	get_node(str(load_save)).grab_focus()

#Check if the current selector is allowed to perform "save" or "load"
func check_permission_save():
	if(SceneSwitcher.caller == "Login"):
		$Save.set_focus_mode(0)
		$Save.disabled = true
	else:
		$Save.set_focus_mode(2)
		$Save.disabled = false

func check_permission_delete(selected_version : int):
	var current_game = "game_save_" + str(selected_version)
	if(user_file[current_game]["Status"] == "active"):
		$Delete.set_focus_mode(2)
		$Delete.disabled = false
	else:
		$Delete.set_focus_mode(0)
		$Delete.disabled = true

func _on_slot_1_focus_entered():
	game_version = 1
	check_permission_delete(1)

func _on_slot_2_focus_entered():
	game_version = 2
	check_permission_delete(2)

func _on_slot_3_focus_entered():
	game_version = 3
	check_permission_delete(3)



