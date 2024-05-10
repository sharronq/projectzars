extends PanelContainer

@export var card: CharData
@export var party = false
@onready var b = get_node('CharacterCollection')

signal selection
signal deselection

var empty = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func initial_connect(char_address : String):
	if (!party or !empty):
		card = load(char_address).duplicate()
		$Icon.texture = card.char_sprite
	connect("mouse_entered", select)
	connect("mouse_exited", unselect)
	$Selected.hide()


func select():
	$Selected.show()
	selection.emit()
	
func unselect():
	$Selected.hide()
	deselection.emit()
	
func h():
	#$Icon.hide()
	empty = true

func refresh():
	if (party and !empty):
		$Icon.texture = card.char_sprite
	else:
		$Icon.texture = null
	$Icon.show()
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("I've been clicked D:")
			#if (party):
				#print("i am party slot " + str(slot))
			select()

func pickFromSlot():
	var inventoryNode = find_parent("CharacterCollection")
	inventoryNode.add_child($Icon)

