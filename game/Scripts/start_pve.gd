extends Button

var enemy_level = 0

func _on_pressed():
	get_tree().change_scene_to_file("res://battler/battler.tscn")
	
func _on_spin_box_value_changed(value):
	SaveLoadManager.selected_fight_level = value
