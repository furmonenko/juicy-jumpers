extends State
class_name AirState

@onready var ground_state = $"../GroundState"
@onready var wall_state :State = $"../WallState"
@onready var falling_state :State = $"../FallingState"

@export var DOUBLE_JUMP_FORCE = -400

var has_double_jump :bool = true

func on_entered():
	has_double_jump = true

func state_process(_delta :float):
	if Input.is_action_just_pressed("Jump") && has_double_jump:
		playback.travel("Double_Jump")
		character.jump(DOUBLE_JUMP_FORCE)
		has_double_jump = false
	
	if character.is_on_wall() && character.velocity.y > 0 && character.velocity.x == 0:
		playback.travel("Wall_Jump")
		next_state = wall_state
		
	elif character.is_on_floor():
		next_state = ground_state
		
	elif character.velocity.y > 0 && !character.is_on_floor():
		playback.travel("Fall")
