extends Control

signal textbox_close
var turn_order: Array = []
var turn_number: int = 1
@onready var player_group_1 = $Players/PlayerGroup1
@onready var enemy_group = $Players/EnemyGroup
@onready var players = $Players
@onready var character = $Players/PlayerGroup1/Character
@onready var anim = $Players/PlayerGroup1/Character/AnimatedSprite2D


var battlers : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	display_text("Battle begin!")
	await $UI/TextContainer/Textbox.hide
	var groups = players.get_children()
	#print(groups.size())
	for i in groups.size():
		var members = groups[i].get_children()
		for j in members.size():
			battlers.append(members[j])
	#battlers.sort_custom(sort_battlers)
	
	while true:
		for character in battlers:
			print(character)
			play_turn(character)
			const TURN_END_DELAY := 1
			await get_tree().create_timer(TURN_END_DELAY).timeout

#static func sort_battlers(a, b) -> bool:
	#return a.Spd > b.Spd

func play_turn(character):
	character.attack()
	if (turn_number % 9 <= 4):
		enemy_group.get_child(0).take_damage(1)
	else:
		player_group_1.get_child(0).take_damage(1)
	print("turn ")
	print(turn_number)
	turn_number += 1
	#if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		


func _input(event):
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		$UI/TextContainer/Textbox.hide()
		#emit_signal("textbox_close")

func display_text(text):
	$UI/TextContainer/Textbox.show()
	$UI/TextContainer/Textbox/Label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
