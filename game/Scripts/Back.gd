extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self.button_pressed)


func button_pressed():
	print("hi")
	get_tree().change_scene_to_file("res://Scenes/GameHome.tscn")
