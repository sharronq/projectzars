extends Label

# Implements text for register and login button on login page 
# for logging in with wrong username/password or trying to register with
# no username or no password.

# On load scene, hide text
func _ready():
	hide()

# Each func hides whatever text was there before, then displays error on signal from
# username script

# Login with wrong user
func _on_username_user_not_found():
	hide()
	text = "No account by that name. 
Please register using the button below or log in as a guest."
	show()

# Login with wrong password
func _on_username_wrong_password():
	hide()
	text = "Incorrect password. Please try again."
	show()
	
# Register with no password
func _on_username_no_password():
	hide()
	text = "Please enter a password."
	show()

# Register with no username
func _on_username_no_username():
	hide()
	text = "Please enter a username."
	show()
