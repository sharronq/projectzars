# Shows confirmation dialogue when user presses battle button. Hides on scene load.
# Used by NavBar.tscn

extends ConfirmationDialog

func _ready():
	self.hide()

func _on_battle_pressed():
	self.show()
	

