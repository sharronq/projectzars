extends Control

# HAVE TO RUN FROM GAMEHOME OTHERWISE IT WONT WORK!!
func _ready():
	$"../NavBar/BattleDialog".hide()
	
	# DISABLES BUTTON IF ALREADY ON THE SCENE IT LEADS TO
	var children = self.get_children() # Array of navbar children: Home, view characters, battle, settings
	var current_scene = self.get_tree().get_current_scene().name
	var scene_dict = {"Home": "Gamehome",
				"View characters": "CharacterCollection",
				"Battle": "Battle",
				"Settings": "Settings"}
	for i in children.slice(0, 4):
		if scene_dict[i.text] == current_scene:
			i.disabled = true

func _on_go_to_saved_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")

func _on_view_characters_pressed():
	get_tree().change_scene_to_file("res://scenes/CharacterCollection.tscn")

func _on_battle_pressed():
	$"../NavBar/BattleDialog".show()
