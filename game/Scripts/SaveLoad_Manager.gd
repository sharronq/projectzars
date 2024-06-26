extends Control

var file_address = "user://user_index_file.json"
var index_file : Dictionary
var index_file_name = "index_file"

var game_save : Dictionary

var selected_fight_level : int = 0

var delete_files = [
	"index_file", "game_save_1", "game_save_2", "game_save_3"
	]

var fight_characters_address : Dictionary = {
	"Archer" = "res://characters/Archer.tres",
	"Guardian" = "res://characters/Guardian.tres",
	"Mage" = "res://characters/Mage.tres",
	"Rogue" = "res://characters/Rogue.tres",
	"Unknown" = "res://characters/Unknown.tres",
	"Warrior" = "res://characters/Warrior.tres",
	
	
	"archer_blue" = "res://characters/archer_blue.tres",
	"pawn_blue" = "res://characters/pawn_blue.tres",
	"pawn_red" = "res://characters/pawn_red.tres",
	"torch_red" = "res://characters/torch_red.tres",
	"warrior_blue" = "res://characters/warrior_blue.tres",
	"warrior_yellow" = "res://characters/warrior_yellow.tres"
}

var fight_enemies_in_each_level : Dictionary = {
	"0" : {
		"c0" : "archer_blue",
		"c1" : "archer_blue",
		"c2" : "",
		"c3" : ""
	},
	"1" : {
		"c0" : "archer_blue",
		"c1" : "archer_blue",
		"c2" : "pawn_blue",
		"c3" : ""
	},
	"2" : {
		"c0" : "archer_blue",
		"c1" : "pawn_blue",
		"c2" : "pawn_blue",
		"c3" : ""
	},
	"3" : {
		"c0" : "pawn_red",
		"c1" : "torch_red",
		"c2" : "pawn_blue",
		"c3" : "torch_red"
	}
}

signal save_successful()
signal load_successful()
signal delete_successful()
signal delete_account_successful()

# Called when the node enters the scene tree for the first time.
func _ready():
	#create_new_game_save()
	pass

#***************** For testing ************ 
func change_file_temp(name : String, age : String):
	pass




#***************** Index file section ******************



#***************** Save index file section ******************
func save_upload_index_file():
	save_index_file_local()
	save_index_file_internet()


func save_index_file_local():
	var file_store = FileAccess.open(file_address, FileAccess.WRITE)
	file_store.store_line(JSON.stringify(index_file))



func save_index_file_internet():
	var auth = Firebase.Auth.auth

	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(auth.localid)
		var task: FirestoreTask = collection.update(index_file_name, index_file)



#***************** Load index file section ******************
func load_index_file_local():
	var file = FileAccess.open(file_address, FileAccess.READ)
	var json = JSON.new()
	var json_parse_result = json.parse(file.get_line())
	if json_parse_result == OK:
		index_file = json.data
	else:
		print("The load_index_file_locally failed")

func load_index_file_internet():
	var auth = Firebase.Auth.auth
	if(auth.localid):
		var collection: FirestoreCollection = Firebase.Firestore.collection(auth.localid)
		var document_task: FirestoreTask = collection.get_doc(index_file_name)
		var document: FirestoreDocument = await document_task.get_document
		index_file = document.doc_fields




#***************** Activate index file section ******************
func update_index_file(current_game_version : int):
	var game_version = "game_save_" + str(current_game_version)
	print("delete", game_version)
	index_file[game_version]["Name"] = get_user_name()
	index_file[game_version]["Status"] = "active"
	#index_file[game_version]["Status"] = "sssssss"
	index_file[game_version]["Level"] = get_user_fight_level()
	index_file[game_version]["Time"] = Time.get_datetime_string_from_system(false, true)
	

#***************** Delete index file section ******************
func delete_index_file(current_game_version : int):
	var game_version = "game_save_" + str(current_game_version)
	index_file[game_version]["Status"] = "inactive"
	save_index_file_internet()
	delete_successful.emit()
	


func delete_all_index_file():
	if(FileAccess.file_exists(file_address)):
		DirAccess.remove_absolute(file_address)










#**************** Game save section *********************


func create_new_game_save():
	game_save["Settings"] = create_settings()
	game_save["Char_collection"] = create_characters_file()
	game_save["Fight"] = create_fight_initials()


func create_characters_file() -> Dictionary:
	var char_file : Dictionary = {
		"Archer" = "unlock",
		"Guardian" = "unlock",
		"Mage" = "lock",
		"Rogue" = "lock",
		"Unknown" = "unlock",
		"Warrior" = "unlock"
	}
	return char_file


func create_settings() -> Dictionary:
	var settings_file : Dictionary = {
		"Screen" = create_settings_screen(),
		"Music" = create_settings_music(),
		"Account" =  create_settings_account()
	}
	
	return settings_file


func create_fight_initials() -> Dictionary:
	var fight_file : Dictionary = {
		"Level" = 0,
		"Team" = create_initial_fight_team()
	}
	
	return fight_file

func create_initial_fight_team() -> Dictionary:
	var fight_team_file : Dictionary = {
		"c0" = "",
		"c1" = "",
		"c2" = "",
		"c3" = ""
	}
	return fight_team_file

func create_settings_screen() -> Dictionary:
	var settings_screen_file : Dictionary = {
		"Resolution" = 2
	}
	return settings_screen_file

func create_settings_music() -> Dictionary:
	var settings_music_file : Dictionary = {
		"Volumn_db" = 60
	}
	return settings_music_file

func create_settings_account() -> Dictionary:
	var settings_account_file : Dictionary = {
		"Name" = "Eren"
	}
	return settings_account_file



func get_user_name() -> String:
	return get_user_settings()["Account"]["Name"]

func get_user_settings() -> Dictionary:
	return game_save["Settings"]

func get_user_fight_team() -> Dictionary:
	return game_save["Fight"]["Team"]

func get_user_fight_level() -> int:
	return game_save["Fight"]["Level"]

func get_user_char_collection() -> Dictionary:
	return game_save["Char_collection"]

func get_selected_fight_level() -> int:
	return selected_fight_level

func get_user_resolution() -> int :
	return game_save["Settings"]["Screen"]["Resolution"]

func get_user_background_db() -> int:
	return game_save["Settings"]["Music"]["Volumn_db"]

func get_fight_characters_address() -> Dictionary:
	return fight_characters_address

func get_user_fight_team_in_array() -> Array:
	var user_team = ["", "", "", ""]
	var user_team_JSON = SaveLoadManager.get_user_fight_team()
	for i in range(0, 4):
		user_team[i] = user_team_JSON["c"+str(i)]
	return user_team

func get_fight_enemies_in_array(selecting_level : int) -> Array:
	var enemy_team : Array = ["", "", "", ""]
	var enemy_team_JSON = fight_enemies_in_each_level[str(selecting_level)]
	for i in range(0, 4):
		enemy_team[i] = enemy_team_JSON["c" + str(i)]
	return enemy_team

func increase_user_fight_level():
	game_save["Fight"]["Level"] += 1

func set_user_name(new_name : String):
	game_save["Settings"]["Account"]["Name"] = new_name

func set_user_resolution(new_resolution_value : int):
	game_save["Settings"]["Screen"]["Resolution"] = new_resolution_value

func set_user_background_db(new_db : int):
	game_save["Settings"]["Music"]["Volumn_db"] = new_db

func set_user_fight_team(spot : int, char_name : String):
	if(spot < 0 or spot >= 4):
		print("The set_user_fight_team can only take range 0 - 3")
		return
	var char_order : String = "c" + str(spot)
	game_save["Fight"]["Team"][char_order] = char_name
	print(game_save["Fight"]["Team"])
#***************** Save actual game section ******************
#Start a new game
func save_game_save_internet(current_game_version : int):
	var auth = Firebase.Auth.auth

	if auth.localid:
		var game_version = "game_save_" + str(current_game_version)
		var collection: FirestoreCollection = Firebase.Firestore.collection(auth.localid)
		var task: FirestoreTask = collection.update(game_version, game_save)
		delete_currentFight()


#save currentFight
func save_currentFight_local():
	var currentFight_address = "user://" + Firebase.Auth.auth["email"] + "_currentFight.json"
	var file_store = FileAccess.open_encrypted_with_pass(currentFight_address, FileAccess.WRITE, Firebase.Auth._config.apiKey)
	file_store.store_line(JSON.stringify(game_save))


#***************** Load actual game section ******************
func load_game_save_internet(current_game_version : int):
	var game_version = "game_save_" + str(current_game_version)
	if(index_file[game_version]["Status"] == "inactive"):
		await create_new_game_save()
		return


	var auth = Firebase.Auth.auth
	if(auth.localid):
		var collection: FirestoreCollection = Firebase.Firestore.collection(auth.localid)
		var document_task: FirestoreTask = collection.get_doc(game_version)
		var document: FirestoreDocument = await document_task.get_document
		game_save = document.doc_fields

func check_currentFight_exist() -> bool:
	var currentFight_address = "user://" + Firebase.Auth.auth["email"] + "_currentFight.json"
	return FileAccess.file_exists(currentFight_address)



func resume_currentFight():
	var currentFight_address = "user://" + Firebase.Auth.auth["email"] + "_currentFight.json"
	var file = FileAccess.open_encrypted_with_pass(currentFight_address, FileAccess.READ, Firebase.Auth._config.apiKey)
	var json = JSON.new()
	var json_parse_result = json.parse(file.get_line())
	if json_parse_result == OK:
		game_save = json.data
		#current Fight should also be resumed
		
	else:
		print("The load_index_file_locally failed")


func create_fight(zars : Array):
	var level : int = selected_fight_level
	var zars_number : int = 0
	#Load my team in a fight
	var team : Array = get_user_fight_team_in_array()
	print(team, "Here is the team")
	

	while zars_number < 8:
		for i in range(4):
			var char_name : String = ""
			if (team[i] != ""):
				char_name = team[i]
				var current_address : String = fight_characters_address[char_name]
				zars[zars_number] = load(current_address).duplicate()

			zars_number+=1
		
		team = get_fight_enemies_in_array(level)
		print(team, "Here is the enemy")

		
		
		
		

#***************** Delete actual game section ******************
func delete_game_save_internet(current_game_version : int):
	var game_version = "game_save_" + str(current_game_version)
	if(index_file[game_version]["Status"] == "inactive"):
		print("The game record is empty!")
		return


	var auth = Firebase.Auth.auth
	if(auth.localid):
		var collection: FirestoreCollection = Firebase.Firestore.collection(auth.localid)
		var document_task: FirestoreTask = collection.delete(game_version)

func delete_currentFight():
	var currentFight_address = "user://" + Firebase.Auth.auth["email"] + "_currentFight.json"
	if (FileAccess.file_exists(currentFight_address)):
		DirAccess.remove_absolute(currentFight_address)










#*****************
#*****************
#*****************
#*****************
#***************** Higher Level Interaction******************



#**************** For Log in Scene ****************
#register initialization index file
func create_new_user(auth):
	var default_stat = {
		"Status" : "inactive",
		"Name" : "Eren",
		"Level" : "1",
		"Time" : "-1"
	}
	#Store 3 default files
	
	for i in range(1, 4):
		var game_version = "game_save_" + str(i)
		index_file[game_version] = default_stat
	
	save_upload_index_file()


func new():
	await load_index_file_internet()





#**************** For game save Scene ****************
#get index file
func get_index_file() -> Dictionary:
	return index_file

func get_Time_and_Level(current_game_version : int) -> Dictionary:
	var result : Dictionary
	var game_version = "game_save_" + str(current_game_version)
	result["Time"] = index_file[game_version]["Time"]
	result["Level"] = index_file[game_version]["Level"]
	
	return result


func Load(current_game_version : int):
	await load_game_save_internet(current_game_version)
	
	load_successful.emit()


func Save(current_game_version : int):
	#update both game save and index file
	save_game_save_internet(current_game_version)
	
	await update_index_file(current_game_version)
	save_index_file_internet()
	save_successful.emit()


func Delete(current_game_version : int):
	await delete_index_file(current_game_version)
	
	delete_game_save_internet(current_game_version)
	
	delete_successful.emit()



func deleteAccount():
	var auth = Firebase.Auth.auth
	delete_all_index_file()
	delete_currentFight()
	if(auth.localid):
		var collection: FirestoreCollection = Firebase.Firestore.collection(auth.localid)
		for filename in delete_files:
			collection.delete(filename)
		
		Firebase.Auth.delete_user_account()
		print("I am deleted")
		delete_account_successful.emit()
