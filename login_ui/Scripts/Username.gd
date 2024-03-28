extends LineEdit

signal user_not_found
signal wrong_password
signal no_username
signal no_password

# Dummy data
#var user_dict = {"Sharron": "password"}
#var password = ""

func _ready():
	grab_focus() # Starts cursor on login text box
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	await load_auth_succeeded()

func _process(_delta):
	pass

func _on_login_pressed():
	var email = text
	var password = $"../Password".text
	if text == "":
		no_username.emit()
		return
	elif password == "":
		no_password.emit()
		return

	Firebase.Auth.login_with_email_and_password(email, password)


func _on_register_pressed():
	var email = text
	var password = $"../Password".text
	if text == "":
		no_username.emit()
		return
	elif password == "":
		no_password.emit()
		return
	
	Firebase.Auth.signup_with_email_and_password(email, password)
	



#Sign up success
#1) Prompt the user a message
#2) Move to LoadSave scene
func on_login_succeeded(auth):
	Firebase.Auth.save_auth(auth)
	#await SaveLoadManager.new()
	get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")


#Sign up success
#1) Prompt the user a message
#2) Save username to file
func on_signup_succeeded(auth):
	Firebase.Auth.save_auth(auth)
	#SaveLoadManager.create_new_user(auth)


#Login in failure
#Prompt the user a message
func on_login_failed(error_code, message):
	if(message == "INVALID_LOGIN_CREDENTIALS"):
		print(message)
		print(error_code)
		user_not_found.emit()
	else:
		print(message)
		wrong_password.emit()


#Sign up failure
#Prompt the user a message
func on_signup_failed(error_code, message):
	$"../Label".text = message
	$"../Label".show()


#Remember user's username from previous successful login attempt
#DO NOT MODIFY THE CODE
func load_auth_succeeded():
	var encrypted_file = await FileAccess.open_encrypted_with_pass("user://user.auth", FileAccess.READ, Firebase.Auth._config.apiKey)
	var success = (encrypted_file != null)
	if(success):
		print(encrypted_file)
		var json = JSON.new()
		var json_parse_result = json.parse(encrypted_file.get_line())

		if(json_parse_result == OK):
			text = json.data["email"]
		else:
			print("Load Auth successded in username.gd error")
