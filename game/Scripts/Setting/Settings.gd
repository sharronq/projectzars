extends Node


@onready var Screen = $Screen

@onready var Music = $Music

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(DisplayServer.screen_get_usable_rect()," the usable")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$Button.disabled = true

func load_user_data():
	Music.change_volumn("Background", SaveLoadManager.get_user_background_db())
	Screen.change_screen_size(SaveLoadManager.get_user_resolution())
