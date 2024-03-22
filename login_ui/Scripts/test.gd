extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	pass

func _process(_delta):
	pass

func _on_timer_timeout():
	var random_number = randi()% 10
	match random_number:
		0: _animated_sprite.play("knight_spin")
		1, 2, 3, 4, 5, 6, 7, 8, 9, 10: _animated_sprite.play("knight_idle")
	
	#
	#print(random_number)
	#if random_number == 0:
		#for i in range(0, 20):
			#self.position.x += 10
			#_animated_sprite.play("default")
			#await get_tree().create_timer(1).timeout
	#if random_number == 1:
		#for i in range(0, 20):
			#self.position.x -= 10
			#_animated_sprite.play("default")
			#await get_tree().create_timer(1).timeout
		
	#match random_number:
		#0: self.position.x += 10
		#1: self.position.x -= 10
		#0, 1: _animated_sprite.play("default")
	
	#_animated_sprite.stop()
