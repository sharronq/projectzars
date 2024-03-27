extends Area2D

@onready var focus = $focus
@onready var progress_bar = $ProgressBar
@onready var animation_player = $AnimationPlayer
@onready var anim = $AnimatedSprite2D

@export var MAX_HEALTH: float = 100
@export var SPD: int = 10

var current_health: float = 100:
	set(value):
		current_health = value
		_update_progress_bar()

var screen_size # Size of the game window.

# Called to update the progress (health) bar
func _update_progress_bar():
	progress_bar.value = (current_health/MAX_HEALTH) * 100
	
func _play_animation():
	anim.play("idle")

func take_damage(value):
	current_health -= value
	
func attack():
	anim.play("attack")
	if (anim.animation_finished):
		anim.play("idle")
	#const TURN_END_DELAY := 1
	#await get_tree().create_timer(TURN_END_DELAY).timeout
	#_play_animation()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
