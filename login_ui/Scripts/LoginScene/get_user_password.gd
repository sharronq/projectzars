# Checks user password against dictionary of known users.
# Used by: Login.tscn

extends LineEdit

# Signals sent to register_login_error_text.gd
signal user_not_found
signal wrong_password
signal no_username
signal no_password

# Dummy data
var user_dict = {"Sharron": "password"}
var password = ""

func _ready():
	grab_focus() # Starts cursor on login text box

# If user presses login button, grab the text from the Username and Password
# nodes and checks if they are correct.
func _on_login_pressed():
	password = get_node("/root/Login/Password").text
	if text in user_dict:
		if password == user_dict[text]:
			# If both user found and password correct, go to their saves
			get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")
		else:
			wrong_password.emit()
	else:
		user_not_found.emit()

# If user presses register, grab the text from the Username and Password
# nodes and if neither are empty, add to the user dictionary.
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
