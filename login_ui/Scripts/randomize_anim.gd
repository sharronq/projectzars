# Randomizes the animation of the sprite on the home screen.
# Used by: GameHome.tscn

extends CharacterBody2D

# Grabs AnimatedSprite2D from node tree
@onready var _animated_sprite = $AnimatedSprite2D

# On timer end, randomize a number. If the number is 0, play the spin animation.
# For any other number, play the idle animation.
func _on_timer_timeout():
	var random_number = randi()% 10
	match random_number:
		0: _animated_sprite.play("knight_spin")
		1, 2, 3, 4, 5, 6, 7, 8, 9, 10: _animated_sprite.play("knight_idle")
