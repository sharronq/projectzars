extends Node2D

var group: Array = []
var index: int = 0
var is_battling : bool = false
var current_character

func _ready():
	set_process_input(true)
	group = get_children()
	#group.sort_custom(self, 'sort_group')
	current_character = get_child(0)
	for i in group.size():
		group[i].position = Vector2(0, i*100)
		group[i]._play_animation()
		if (i == 1 or i == 2):
			group[i].position = Vector2(100, i*100)
	

#static func sort_group(a : ) -> bool:
	#return a.spd

func turn_pass():
	var new_index : int = (current_character.get_index() + 1) % get_child_count()
	current_character = get_child(new_index)
	

func _process(_delta):
	if Input.is_key_pressed(KEY_SPACE):
		turn_pass()

