extends Path2D

@onready var path_follow = $PathFollow2D
@onready var saw = $PathFollow2D/Saw

@export var MOVEMENT_RATIO = 0.2

func _physics_process(delta: float) -> void:
	if path_follow.progress_ratio >= 0.95:
		MOVEMENT_RATIO = -MOVEMENT_RATIO
		saw.anim_sprite.play()
		saw.play_sound()
	elif path_follow.progress_ratio <= 0.05:
		MOVEMENT_RATIO = -MOVEMENT_RATIO
		saw.anim_sprite.play_backwards()
		saw.play_sound()
	path_follow.progress_ratio += MOVEMENT_RATIO * delta
