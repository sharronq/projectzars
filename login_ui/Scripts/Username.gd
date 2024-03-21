extends LineEdit

signal user_not_found
signal wrong_password
signal no_username
signal no_password

# Dummy data
var user_dict = {"Sharron": "password"}
var password = ""

func _ready():
	grab_focus() # Starts cursor on login text box

func _process(_delta):
	pass

func _on_login_pressed():
	password = get_node("/root/Login/Password").text
	if text in user_dict:
		if password == user_dict[text]:
			get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")
		else:
			wrong_password.emit()
	else:
		user_not_found.emit()
		print("user not found")

func _on_register_pressed():
	password = get_node("/root/Login/Password").text
	if text == "":
		no_username.emit()
		return
	elif password == "":
		no_password.emit()
		return
	user_dict[text] = password
	get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")
	print("new account made")
