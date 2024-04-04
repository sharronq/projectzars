extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_username_no_password():
	text = "Please enter a password."
	show()

func _on_username_no_username():
	text = "Please enter a username."
	show()

func _on_username_login_error():
	text = "Wrong username or password. Please try again or register
	using the button below."
	show()
