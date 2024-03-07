extends CanvasLayer

var game_version : int

#mode between loading or saving file
var load_save : String
var user_file : Dictionary



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	SaveLoadManager.save_successful.connect(save_successed)
	SaveLoadManager.delete_successful.connect(delete_successed)
	
	game_version = -1
	user_file = SaveLoadManager.get_index_file()
	
	update_label()



func _on_game_save_1_pressed():
	game_version = 1
	$game_version_shown.text = "Game 1 selected"

func _on_game_save_2_pressed():
	game_version = 2
	$game_version_shown.text = "Game 2 selected"

func _on_game_save_3_pressed():
	game_version = 3
	$game_version_shown.text = "Game 3 selected"



func _on_main_menu_change_to_game_save(type):
	load_save = type
	show()


func _on_comfirm_pressed():
	if(game_version == -1):
		$game_version_shown.text = "Please select a record"
		return

	if(load_save == "save"):
		SaveLoadManager.Save(game_version)
	else:
		SaveLoadManager.Load(game_version)
	
	



func _on_exit_pressed():
	hide()


func _on_delete_pressed():
	if(game_version == -1):
		$game_version_shown.text = "Please select a record"
		return

	SaveLoadManager.Delete(game_version)
	


func save_successed():
	update_label()


func delete_successed():
	update_label()


func update_label():
	for i in range(1, 4):
		var game_save = "game_save_" + str(i)
		if(user_file[game_save]["Status"] == "inactive"):
			get_node(game_save).text = "Empty"
		else:
			var name = user_file[game_save]["Name"]
			var age = user_file[game_save]["Age"]
			get_node(game_save).text = name + " " + age



