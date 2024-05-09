extends Node

@onready var background_player = $"Background Music"

func _ready():
	SceneSwitcher.scene_changed.connect(scene_changed)
	
func change_volumn(bus_name : String, value : int):
	SaveLoadManager.set_user_background_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(
		bus_index,
		#Divide by 100 is because linear() takes from 0 - 1, and the slider has value from 0 - 100
		linear_to_db(value/100.0)
	)
	print(value/100.0)
	pass


func scene_changed(new_scene : String):
	var stream : AudioStreamMP3
	if(new_scene == "Login"):
		stream = preload("res://Scripts/Setting/Music/Background Music/Login_Music Guitar.mp3")
	elif(new_scene == "Home"):
		stream = preload("res://Scripts/Setting/Music/Background Music/Home_IntoTheWild.mp3")
	else:
		stream = preload("res://Scripts/Setting/Music/Background Music/Home_IntoTheWild.mp3")
	
	background_player.stream = stream
	background_player.play()

func stop_background_music():
	background_player.stream_paused = true

func start_background_music():
	background_player.stream_paused = false
