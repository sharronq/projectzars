extends Battler

@onready var characters = $Characters.get_children()
#test

func _ready():
	zars.resize(8)
	for i_character in characters:
		i_character.attack_played.connect(attackFinished)
	
	SaveLoadManager.create_fight(zars)
	startBattle()
	updateAll()
	playNextTurn()
	_on_play_toggled(true)




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
	characters[victim].data = zars[victim]
	characters[victim].playHurt(damage)

func _on_battle_ended(members_left):
	if (members_left):
		$Result/ResultLabel.text = "VICTORY"
		if(SaveLoadManager.get_selected_fight_level() == SaveLoadManager.get_user_fight_level()):
			SaveLoadManager.increase_user_fight_level()
	else:
		$Result/ResultLabel.text = "DEFEAT"
	$Result.visible = true


func _on_close_button_pressed():
	get_tree().change_scene_to_file("res://scenes/BattleSelect.tscn")

func _on_tree_exiting():
	Engine.time_scale = 1.0

func _on_pause_toggled(toggled_on):
	if (toggled_on):
		Engine.time_scale = 0.0
		$ControlPanel/Controls/Pause.modulate = Color("#c68b58")
	else:
		$ControlPanel/Controls/Pause.modulate = Color("#895b33")

func _on_play_toggled(toggled_on):
	if (toggled_on):
		Engine.time_scale = 1.0
		$ControlPanel/Controls/Play.modulate = Color("#c68b58")
	else:
		$ControlPanel/Controls/Play.modulate = Color("#895b33")

func _on_fast_toggled(toggled_on):
	if (toggled_on):
		Engine.time_scale = 2.0
		$ControlPanel/Controls/Fast.modulate = Color("#c68b58")
	else:
		$ControlPanel/Controls/Fast.modulate = Color("#895b33")
