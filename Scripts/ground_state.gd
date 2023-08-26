extends State
class_name GroundState

@onready var air_state :State = $"../AirState"

@export var JUMP_FORCE = -400

func on_entered():
	playback.travel("Idle & Walk")

func state_process(_delta :float):
	if Input.is_action_just_pressed("Jump"):
		playback.travel("Jump")
		character.jump(JUMP_FORCE)
		
		next_state = air_state

	# Coyote Timer.
	# If character was on floor and now character isn't - we create timer while we still considered being in GroundState.
	# If timer is finished and we still didn't jump - we go to falling state.
	if character.was_on_floor && !character.is_on_floor():
		await get_tree().create_timer(0.2).timeout
		next_state = air_state
