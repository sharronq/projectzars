extends Battler

@onready var characters = $Characters.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	zars.resize(8)
	for i_character in characters:
		i_character.attack_played.connect(attackFinished)
	zars[0] = preload("res://characters/warrior_yellow.tres").duplicate()
	zars[1] = preload("res://characters/warrior_blue.tres").duplicate()
	zars[2] = preload("res://characters/pawn_blue.tres").duplicate()
	zars[3] = preload("res://characters/archer_blue.tres").duplicate()
	zars[4] = preload("res://characters/pawn_red.tres").duplicate()
	zars[5] = preload("res://characters/torch_red.tres").duplicate()
	zars[6] = preload("res://characters/pawn_blue.tres").duplicate()
	zars[7] = preload("res://characters/torch_red.tres").duplicate()
	startBattle()
	updateAll()
	playNextTurn()

func updateAll():
	for i in 8:
		characters[i].data = zars[i]
		characters[i].update()
	for i in range(4, 8):
		characters[i].face_left()
	updateTurnOrder()

func updateTurnOrder():
	for temp in $TurnOrder.get_children():
		temp.free()
	for i in turn_order.size():
		var temp = preload("res://battler/turn_order_panel.tscn").instantiate()
		temp.data = zars[turn_order[i]]
		if (turn_order[i] >= 4):
			temp.face_left()
		if (i == getCurrentTurn()):
			temp.setActive()
		$TurnOrder.add_child(temp)

func attackFinished():
	updateAll()
	playNextTurn()

func _on_turn_played(attacker, victim, damage):
	characters[attacker].playAttack()
