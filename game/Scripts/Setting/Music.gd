extends Node

func _ready():
	var bus_index = AudioServer.get_bus_index("Background")
	print(AudioServer.get_bus_volume_db(bus_index))
	pass
	
func change_volumn(bus_name : String, value : int):

	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(
		bus_index,
		#Divide by 100 is because linear() takes from 0 - 1, and the slider has value from 0 - 100
		linear_to_db(value/100.0)
	)
	print(value/100.0)
	pass
