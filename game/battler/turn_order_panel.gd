extends CenterContainer

var data: CharData 

func update():
	if (data):
		$Sprite.sprite_frames = data.sprite_frames
		$Sprite.animation = "idle"
		visible = true
	else:
		visible = false

func face_left():
	$Sprite.flip_h = 1
	$BGColor.color = Color(0.5, 0, 0, 0.5)

func setActive():
	$BGColor.color = Color(0, 0.5, 0, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	update()
