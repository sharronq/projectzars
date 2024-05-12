extends Node2D

const SlotClass = preload("res://Scripts/slot.gd")
@onready var card_slots = $VBoxContainer/Inventory
@onready var party_slots = $VBoxContainer/Party
@onready var stats_panel = $StatsPanel

var inventory = []
var holding_char = null
var has_duplicate = false
var user_team : Array = ["", "", "", ""]

# Called when the node enters the scene tree for the first time.
func _ready():
	for slots in party_slots.get_children():
		#inventory.append(slots)
		slots.gui_input.connect(slot_gui_input.bind(slots))
		slots.selection.connect(show_info.bind(slots))
		slots.deselection.connect(hide_info)
	for slots in card_slots.get_children():
		inventory.append(slots)
		slots.gui_input.connect(card_gui_input.bind(slots))
		slots.selection.connect(show_info.bind(slots))
		slots.deselection.connect(hide_info)
	initial_party()
 

func initial_party():
	user_team = SaveLoadManager.get_user_fight_team_in_array()
	
	var slot_number : int = 1
	var char_address : Dictionary = SaveLoadManager.get_fight_characters_address()
	for i in range(4):
		#move to each slot
		var prefix : String = "VBoxContainer/Party/"
		var slot : String = "PartySlot" + str(i + 1)
		
		var char_name = user_team[i]
		
		#If current slot doesn't select a character, move to next slot
		if(char_name == ""):
			continue
		var node = get_node(prefix + slot)

		node.initial_connect(char_address[char_name])

func show_info(slot: SlotClass):
	if (slot.card):
		var text = "Name: " + slot.card.name + '\n'
		text += "HP: " + str(slot.card.health) + '\n'
		text += "Attack: " + str(slot.card.attack) + '\n'
		text += "Speed: " + str(slot.card.speed) + '\n'
		
		$StatsPanel/Label.text = text
		
		stats_panel.show()
	
func hide_info():
	stats_panel.hide()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#Remove card from party
			slot.card = null
			slot.empty = true
			slot.refresh()
			
			#Remove from firebase file
			var spot : int = int(slot.name.substr(slot.name.length() - 1, 1))
			remove_team_member(spot)

func card_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print(slot.card.name)
			for s in user_team:
				# Check for dupes
				if (s == slot.card.name):
					print("This member already is in the party!")
					return
			for slots in party_slots.get_children():
				if (!slots.card):
					#Add card to party
					slots.card = slot.card
					slots.empty = false
					slots.refresh()
					
					#Update to firebase file
					var spot : int = int(slots.name.substr(slots.name.length() - 1, 1))
					set_team_member(spot, slot.card.name)
					break


func card_selection(slot: SlotClass):
	print("s")


func _input(event):
	if holding_char:
		holding_char.global_position = get_global_mouse_position()

func set_team_member(spot : int, char_name : String):
	SaveLoadManager.set_user_fight_team(spot - 1, char_name)
	user_team = SaveLoadManager.get_user_fight_team_in_array()

func remove_team_member(spot : int):
	SaveLoadManager.set_user_fight_team(spot - 1, "")
	user_team = SaveLoadManager.get_user_fight_team_in_array()


	#for card_slot in card_slots.get_children():
		#card_slot.connect("gui_input", "slot_gui_input", [card_slot])
#
#func slot_gui_input(event: InputEvent, slot: SlotClass):
	#if event is InputEventMouseButton:
		#if event.button_index == BUTTON_LEFT && event.pressed:
			#if holding_card != null:
				#if !slot.item:
					#slot.putIntoSlot(holding_card)
					#holding_card = null
				#else:					#var temp_item = slot_item
					#slot.pickFromSlot()
					#temp_item.global_position = event.global_position
					#slot.putIntoSlot(holding_card)
					#holding_card = temp_item
			#elif slot.item:
				#holding_card = slot.item
				#slot.pickFromSlot()
				#holding_card.global_position = get_global_mouse_position()

