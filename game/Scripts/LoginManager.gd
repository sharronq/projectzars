extends LineEdit

signal login_error
signal login_successful
signal no_username
signal no_password
signal signup_successful

func _ready():
	grab_focus() # Starts cursor on login text box
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	await load_auth_succeeded()

func _process(delta):
	if Input.is_action_just_pressed("Comfirm"):
		if $".".has_focus():
			$"../Password".grab_focus()
		elif $"../Password".has_focus():
			$"../Login".grab_focus()
			$"../Login".emit_signal("pressed")



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
	$"../Label".text = "Login successful!"
	$"../Label".show()
	await SaveLoadManager.new()
	
	await get_tree().create_timer(1).timeout
	SceneSwitcher.notify("Login", "LoadSave")
	get_tree().change_scene_to_file("res://scenes/LoadSave.tscn")
	#get_tree().change_scene_to_file("res://scenes/navbar_2.tscn")

#Sign up success
#1) Prompt the user a message
#2) Save username to file
func on_signup_succeeded(auth):
	Firebase.Auth.save_auth(auth)
	SaveLoadManager.create_new_user(auth)
	
	$"../Label".text = "Registration successful!"
	$"../Label".show()

#Login in failure
#Prompt the user a message
func on_login_failed(error_code, message):
	if(message == "INVALID_LOGIN_CREDENTIALS"):
		print(message)
		print(error_code)
		$"../Label".text = "Incorrect email or password. 
		Please try again or register with the button below."
		$"../Label".show()

#Sign up failure
#Prompt the user a message
func on_signup_failed(error_code, message):
	print(message)
	print(error_code)
	if message == "INVALID_EMAIL":
		$"../Label".text = "Please enter a valid email."
	elif message == "WEAK_PASSWORD : Password should be at least 6 characters":
		$"../Label".text = "Password should be at least 6 characters."
	elif message == "EMAIL_EXISTS":
		$"../Label".text = "An account with this email already exists."
	
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
