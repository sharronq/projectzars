extends Node2D

@export var data: CharData

signal attack_played

func update():
	if (data):
		$Sprite.sprite_frames = data.sprite_frames
		$Sprite.animation = "idle"
		$Sprite.play()
		$HPLabel.text = str(data.getCurrentHealth()) + "/" + str(data.getHealth())
		var tween = get_tree().create_tween()
		tween.tween_property($HPBar, "value", data.getCurrentHealth() * 100 / float(data.getHealth()), 0.5)
		#$HPBar.value = data.getCurrentHealth() * 100 / data.getHealth()
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
	attack_played.emit()
