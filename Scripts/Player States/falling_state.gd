extends State
class_name FallingState

@onready var ground_state = $"../GroundState"
@onready var wall_state = $"../WallState"

@export var DOUBLE_JUMP_FORCE = -400

var has_double_jump :bool = true

func state_process(_delta :float):
	if character.is_on_floor():
		next_state = ground_state
	if character.is_on_wall():
		next_state = wall_state
		
	if Input.is_action_just_pressed("Jump") && has_double_jump:
		playback.travel("Double_Jump")
		character.jump(DOUBLE_JUMP_FORCE)
		has_double_jump = false
