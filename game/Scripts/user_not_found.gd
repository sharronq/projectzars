extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_username_user_not_found():
	hide()
	text = "No account by that name. 
Please register using the button below or log in as a guest."
	show()

func _on_username_wrong_password():
	hide()
	text = "Incorrect password. Please try again."
	show()
	
func _on_username_no_password():
	hide()
	text = "Please enter a password."
	show()

func _on_username_no_username():
	hide()
	text = "Please enter a username."
	show()
