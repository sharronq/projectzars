extends Node2D

@export var data: CharData

signal attack_played

func update():
	if (data):
		$Sprite.sprite_frames = data.sprite_frames
		$Sprite.animation = "idle"
		$Sprite.play()
		$HPLabel.text = str(data.getCurrentHealth()) + "/" + str(data.getHealth())
		#var tween = get_tree().create_tween()
		#tween.tween_property($HPBar, "value", data.getCurrentHealth() * 100 / float(data.getHealth()), 0.5)
		$HPBar.value = data.getCurrentHealth() * 100.0 / data.getHealth()
		visible = true
		$Sprite.modulate = Color.WHITE
	else:
		visible = false

func face_left():
	$Sprite.flip_h = 1

func playAttack():
	$Sprite.animation = "attack"
	$Sprite.play()

func playHurt(damage:int):
	await get_tree().create_timer(0.5).timeout
	$Sprite.modulate = Color.RED
	var temp = Label.new()
	temp.text = str(-damage)
	temp.position = Vector2(48, -48)
	temp.set("theme_override_font_sizes/font_size", 24)
	temp.set("theme_override_colors/font_color", Color.DARK_RED)
	add_child(temp)
	var tween = get_tree().create_tween()
	if data:
		tween.tween_property($HPBar, "value", data.getCurrentHealth() * 100 / float(data.getHealth()), 0.5)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(temp, "position", Vector2(48, 24), 0.5)
	await tween2.finished
	temp.free()

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

func _on_sprite_animation_finished():
	$Sprite.animation = "idle"
	$Sprite.play()
	attack_played.emit()
