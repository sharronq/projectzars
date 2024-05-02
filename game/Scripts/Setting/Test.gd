extends Control

@onready var Screen_container = $frame/VBoxContainer/Settings_container/Screen_setting
@onready var Screen_button = $frame/VBoxContainer/HBoxContainer/Screen_button
@onready var Resolution_option = $frame/VBoxContainer/Settings_container/Screen_setting/Resolution_Option

@onready var Music_container = $frame/VBoxContainer/Settings_container/Music_container
@onready var Music_button = $frame/VBoxContainer/HBoxContainer/Music_button
@onready var volume_slider = $frame/VBoxContainer/Settings_container/Music_container/Background_Slider
@onready var volumn_label = $frame/VBoxContainer/Settings_container/Music_container/Label

@onready var Account_container = $frame/VBoxContainer/Settings_container/Account_ontainer
@onready var Account_button = $frame/VBoxContainer/HBoxContainer/Account_button
@onready var Username = $frame/VBoxContainer/Settings_container/Account_ontainer/Username
@onready var Delete_warning = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning
@onready var Delete_label = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning/Label
@onready var Delete_line = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning/Delete_line
@onready var Delete_button = $frame/VBoxContainer/Settings_container/Account_ontainer/DeleteAccount/Delete_warning/Delete_button

func _ready():
	SaveLoadManager.delete_account_successful.connect(delete_account_successful)
	
	Screen_button.grab_focus()
	
	volume_slider.value = SaveLoadManager.get_user_background_db()
	volumn_label.text = str(volume_slider.value) + "%"
	Username.text = SaveLoadManager.get_user_name()
	Delete_label.text = Delete_label.text + Firebase.Auth.auth["email"] + ") in the following box"


func _on_background_slider_value_changed(value : int):
	volumn_label.text = str(value) + "%"
	Settings.Music.change_volumn("Background", value)



func _on_resolution_option_item_selected(index):
	Settings.Screen.change_screen_size(index)





func _on_screen_button_focus_entered():
	hide_settings()
	
	Screen_container.show()


func _on_music_button_focus_entered():
	hide_settings()
	
	Music_container.show()
	


func _on_account_button_focus_entered():
	hide_settings()
	
	Account_container.show()
	

func hide_settings():
	Screen_container.hide()
	Music_container.hide()
	Account_container.hide()


func _on_username_text_submitted(new_text):
	SaveLoadManager.set_user_name(new_text)
	var Username_label = $frame/VBoxContainer/Settings_container/Account_ontainer/Username/Label
	Username_label.text = "*Saved"


func _on_username_text_changed(new_text):
	var Username_label = $frame/VBoxContainer/Settings_container/Account_ontainer/Username/Label
	if(new_text == SaveLoadManager.get_user_name()):
		Username_label.text = ""
		return

	Username_label.text = "*Unsaved"

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
	SceneSwitcher.notify("Setting", "Login")
	SceneSwitcher.to_login()



func _on_music_backgroun_check_box_toggled(toggled_on):
	if(toggled_on == true):
		Settings.Music.start_background_music()
	else:
		Settings.Music.stop_background_music()
