extends Button

func button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	print("Back to home!")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self.button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
