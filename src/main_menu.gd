extends Node


signal change_to_game_save(type : String)


func _on_logout_pressed():
	pass
	

func _on_save_mode_pressed():
	
	change_to_game_save.emit("save")
	


func _on_load_mode_pressed():
	change_to_game_save.emit("load")


func _on_game_save_game_save_version(version, status, mode):
	pass



func _on_change_name_pressed():
	var name = $Name.text
	var age = $Age.text
	if(name == "" or age == ""):
		print("One of the element is missing, please reenter")
	else:
		$Name_shown.text = name
		$Age_shown.text = age
		
	SaveLoadManager.game_save["Name"] = name
	SaveLoadManager.game_save["Age"] = age



