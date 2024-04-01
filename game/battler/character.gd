extends Node2D

@export var data: CharData

func update():
	if (data):
		$Sprite.sprite_frames = data.sprite_frames
		$Sprite.animation = "idle"
		$Sprite.play()
		visible = true
	else:
		visible = false

func face_left():
	$Sprite.flip_h = 1

func playAttack():
	$Sprite.animation = "attack"
	$Sprite.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

func _on_sprite_animation_finished():
	$Sprite.animation = "idle"
	$Sprite.play()
