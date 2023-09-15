extends State
class_name WallState

@onready var ground_state :State = $"../GroundState"
@onready var air_state :State = $"../AirState"
@onready var falling_state :State = $"../FallingState"

func on_entered():
	playback.travel("Wall_Jump")
	# character.direction = -character.direction

func state_process(_delta):
	if Input.is_action_just_pressed("Jump"):
		character.wall_jump()
		playback.travel("Double_Jump")
		
	if character.is_on_wall() && character.velocity.y > 0:
		character.velocity.y = 10
	else:
		next_state = falling_state
		
	if Input.is_action_just_pressed("Move Left") || Input.is_action_just_pressed("Move Right"):
		playback.travel("Fall")
		character.direction = -character.direction
		character.velocity.x = character.direction * 100
		next_state = air_state
	
	if character.is_on_floor():
		next_state = ground_state
