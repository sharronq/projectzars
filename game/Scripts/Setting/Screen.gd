extends Node

#var resolutions = [
	#Vector2(1456,816),
	#Vector2(1152,648),  #Mini 1.0
	#Vector2(1382, 777), #Small 1.2
	#Vector2(1782, 1002), #Medium 1.5
	#Vector2(2304, 1296), #Large 2.0
	#Vector2(2880, 1548) #Full
#]

func _ready():
	initialize_resolution()

var resolutions : Array

func initialize_resolution():
	var user_screen_size = DisplayServer.screen_get_usable_rect().size
	#var ratio : float = 816 / 1456.0
	var ratio : float = 648 / 1152.0 
	resolutions.append(calculate_new_resolution(user_screen_size, 0.3, ratio)) #Mini 0.3
	resolutions.append(calculate_new_resolution(user_screen_size, 0.5, ratio)) #Small 0.5
	resolutions.append(calculate_new_resolution(user_screen_size, 0.7, ratio)) #Medium 0.7
	resolutions.append(calculate_new_resolution(user_screen_size, 0.85, ratio)) #Large 0.85
	resolutions.append(user_screen_size) #Full 1.0
	
	
	#Full
	#resolutions.append(user_screen_size.size) #Full 1.0
	
	
	
	
	
func change_screen_size(choice : int):
	var expect_size = resolutions[choice]
	var viewport = get_viewport()


	#change the viewport size
	viewport.set_size(expect_size)
	viewport.set_position(center_middle())
	
	print(DisplayServer.window_get_size(), " The window size")
	print(viewport.size, " The viewport size")



func calculate_new_resolution(origin : Vector2i, minimize_ratio : float, overall_ratio : float) -> Vector2i:
	var new_length : int = origin[0] * minimize_ratio
	var new_width : int = new_length * overall_ratio
	
	return Vector2i(new_length, new_width)


func center_middle() -> Vector2i:
	var user_screen_size : Vector2i = DisplayServer.screen_get_usable_rect().size
	var window_size : Vector2i = DisplayServer.window_get_size()
	var new_position : Vector2i = Vector2i(0, 0) + (user_screen_size - window_size) / 2
	
	return new_position
	
