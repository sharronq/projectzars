# Added to a control node in every scene. Takes signals from buttons that
# change scenes and performs the scene change on button press.
# Used by: every scene

extends Node

# NAVIGATION BUTTONS (GAMEHOME)
# Battle dialog "Start PVE" button (after pressing "Battle" button)
func _on_confirmation_dialog_confirmed():
	get_tree().change_scene_to_file("res://Scenes/Navbar Scenes/Battle.tscn")

# Home button (on every scene except Gamehome)
func _on_home_pressed():
	get_tree().change_scene_to_file("res://Scenes/Navbar Scenes/GameHome.tscn")

func _on_view_characters_pressed():
	get_tree().change_scene_to_file("res://Scenes/Navbar Scenes/CharacterCollection.tscn")
	

# LOAD SAVE SCENE BUTTONS
func _on_slot_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Navbar Scenes/GameHome.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")

func _on_back_to_saves_pressed():
	get_tree().change_scene_to_file("res://Scenes/LoadSave.tscn")
