extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self.button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func button_pressed():
	SceneSwitcher.notify("Home", "Login")
	get_tree().change_scene_to_file("res://Scenes/login.tscn")
