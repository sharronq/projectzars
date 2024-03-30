# Disables buttons on the navbar if user is already on the page that the button leads.
# Used by: NavBar.tscn, GameHome.tscn, CharacterCollection.tscn, Settings.tscn

extends Button

# Checks the current scene and if the name matches what the button is,
# disables the button.
# There's probably a better way to do this :')
func disable_button():
	if get_scene_name() == "Gamehome" && self.text == "Home":
		self.disabled = true
	if get_scene_name() == "Viewcharacters" && self.text == "View characters":
		self.disabled = true
	if get_scene_name() == "Settings" && self.text == "Settings":
		self.disabled = true

# Grabs scene name from tree
func get_scene_name():
	return get_tree().get_current_scene().name

# On scene enter, disables the corresponding button.
func _ready():
	disable_button()
	pass
