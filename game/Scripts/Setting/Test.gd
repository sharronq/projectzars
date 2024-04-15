extends Control

func _ready():
	$Background_Slider.value = 60
	$Background_Slider.step = 2
	
	add_item_resolution()
	
	

func _on_background_slider_value_changed(value : int):
	$Background_Slider/BVolumn_percentage.text = str(value) + "%"
	Settings.Music.change_volumn("Background", value)



func _on_resolution_option_item_selected(index):
	Settings.Screen.change_screen_size(index)

func add_item_resolution():
	var list = $Resolution_Option
	list.add_item("Mini")
	list.add_item("Small")
	list.add_item("Medium")
	list.add_item("Large")
	list.add_item("Full")
	


