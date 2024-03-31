extends Battler

@onready var characters = $Characters.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	zars.resize(8)
	zars[0] = preload("res://characters/warrior_yellow.tres")
	zars[1] = preload("res://characters/warrior_blue.tres")
	zars[2] = preload("res://characters/pawn_blue.tres")
	zars[3] = preload("res://characters/archer_blue.tres")
	zars[4] = preload("res://characters/pawn_red.tres")
	zars[5] = preload("res://characters/torch_red.tres")
	zars[6] = preload("res://characters/pawn_red.tres")
	zars[7] = preload("res://characters/torch_red.tres")
	updateAll()

func updateAll():
	for i in 8:
		characters[i].data = zars[i]
		characters[i].update()
	for i in range(4, 8):
		characters[i].face_left()
