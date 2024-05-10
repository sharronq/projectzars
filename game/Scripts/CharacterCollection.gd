extends Node2D

const SlotClass = preload("res://Scripts/slot.gd")
@onready var card_slots = $VBoxContainer/Inventory
@onready var party_slots = $VBoxContainer/Party
@onready var stats_panel = $StatsPanel

var inventory = []
var holding_char = null
var has_duplicate = false


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

func show_info(slot: SlotClass):
	if (slot.card):
		$StatsPanel/Label.text = "Name: " + slot.card.name
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

func card_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			has_duplicate = false
			print(slot.card.name)
			for s in party_slots.get_children():
				# Check for dupes
				if (s.card == slot.card):
					has_duplicate = true
			for slots in party_slots.get_children():
				if (!slots.card and !has_duplicate):
					#Add card to party
					slots.card = slot.card
					slots.empty = false
					slots.refresh()
					break
				elif (has_duplicate):
					print("This member already is in the party!")
					break

func card_selection(slot: SlotClass):
	print("s")


func _input(event):
	if holding_char:
		holding_char.global_position = get_global_mouse_position()

func set_team_member(spot : int, char_name : String):
	SaveLoadManager.set_user_fight_team(spot, char_name)

func remove_team_member(spot : int):
	SaveLoadManager.set_user_fight_team(spot, "")
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

