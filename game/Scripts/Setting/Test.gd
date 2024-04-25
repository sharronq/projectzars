extends Control

@onready var Screen_container = $frame/VBoxContainer/Settings_container/Screen_setting
@onready var Resolution_option = $frame/VBoxContainer/Settings_container/Screen_setting/Resolution_Option

@onready var Music_container = $frame/VBoxContainer/Settings_container/Music_container
@onready var volume_slider = $frame/VBoxContainer/Settings_container/Music_container/Background_Slider
@onready var volumn_label = $frame/VBoxContainer/Settings_container/Music_container/Label

@onready var Account_container = $frame/VBoxContainer/Settings_container/Account_ontainer
@onready var Username = $frame/VBoxContainer/Settings_container/Account_ontainer/Username
@onready var Delete_warning = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning
@onready var Delete_label = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning/Label
@onready var Delete_line = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning/Delete_line
@onready var Delete_button = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning/Delete_button

func _ready():
	SaveLoadManager.delete_account_successful.connect(delete_account_successful)
	
	volumn_label.text = str(volume_slider.value) + "%"
	Username.text = SaveLoadManager.game_save["Name"]
	Delete_label.text = Delete_label.text + Firebase.Auth.auth["email"] + ") in the following box"


func _on_background_slider_value_changed(value : int):
	volumn_label.text = str(value) + "%"
	Settings.Music.change_volumn("Background", value)



func _on_resolution_option_item_selected(index):
	Settings.Screen.change_screen_size(index)





func _on_screen_button_pressed():
	hide_settins()
	Screen_container.show()


func _on_music_button_pressed():
	hide_settins()
	Music_container.show()


func _on_account_button_pressed():
	hide_settins()
	Account_container.show()


func hide_settins():
	Screen_container.hide()
	Music_container.hide()
	Account_container.hide()


func _on_username_text_submitted(new_text):
	SaveLoadManager.game_save["Name"] = new_text


func _on_delete_account_pressed():
	Delete_warning.show()


func _on_back_pressed():
	SceneSwitcher.back()



func _on_delete_back_pressed():
	Delete_warning.hide()
	Delete_line.clear()
	Delete_button.disabled = true


func _on_delete_line_text_changed(new_text):
	if new_text == Firebase.Auth.auth["email"]:
		Delete_button.disabled = false
	else:
		Delete_button.disabled = true


func _on_delete_button_pressed():
	SaveLoadManager.deleteAccount()

func delete_account_successful():
	SceneSwitcher.login()
