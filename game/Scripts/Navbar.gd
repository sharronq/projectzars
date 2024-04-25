extends Control

# HAVE TO RUN FROM GAMEHOME OTHERWISE IT WONT WORK!!
func _ready():
	
	# DISABLES BUTTON IF ALREADY ON THE SCENE IT LEADS TO
	var children = self.get_children() # Array of navbar children: Home, view characters, battle, settings
	var current_scene = self.get_tree().get_current_scene().name
	var scene_dict = {"Home": "Gamehome",
				"View characters": "CharacterCollection",
				"Battle": "BattleSelect",
				"Settings": "Settings"}
	for i in children.slice(0, 4):
		if scene_dict[i.text] == current_scene:
			i.disabled = true

func _on_go_to_saved_game_button_pressed():
	SceneSwitcher.notify("Home", "LoadSave")
	get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")

func _on_view_characters_pressed():
	get_tree().change_scene_to_file("res://scenes/CharacterCollection.tscn")

func _on_battle_pressed():
	get_tree().change_scene_to_file("res://scenes/BattleSelect.tscn")

func _on_home_pressed():
	get_tree().change_scene_to_file("res://scenes/Gamehome.tscn")

func _on_settings_pressed():
	SceneSwitcher.notify("Home", "Setting")
	get_tree().change_scene_to_file("res://Scripts/Setting/Test.tscn")
