extends Node

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	
	
	if Firebase.Auth.check_auth_file():
		var auth = Firebase.Auth.auth
		$Email.text = auth["email"]



func _on_login_pressed():
	var email = $Email.text
	var password = $Password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$Message.text ="Loging in..."


func _on_sign_up_pressed():
	var email = $Email.text
	var password = $Password.text

	Firebase.Auth.signup_with_email_and_password(email, password)
	$Message.text = "Signing up..."



func on_login_succeeded(auth):
	$Message.text = "Login Success!"
	Firebase.Auth.save_auth(auth)
	await SaveLoadManager.new()
	get_tree().change_scene_to_file("res://main_menu.tscn")

	
func on_signup_succeeded(auth):
	$Message.text = "Signup Success!"
	Firebase.Auth.save_auth(auth)
	SaveLoadManager.create_new_user(auth)
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$Message.text = "Login failed. Error: %s" % message
	
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	$Message.text = "Signup failed. Error: %s" % message

#forget password

