extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func update_label(label_num : int):
	var game_save = "game_save_" + str(label_num)
	var user_file = SaveLoadManager.get_index_file()
	$".".text = ""
	if(user_file[game_save]["Status"] == "inactive"):
			$".".text = "Save slot " + str(label_num)
	else:
		$Rank.text = "Rank: " + user_file[game_save]["Level"]
		$"Last save".text = user_file[game_save]["Time"]
		$"Player name".text = user_file[game_save]["Name"]
		show_label()

func show_label():
	$Rank.show()
	$"Last save".show()
	$"Player name".show()
