extends State

class_name HitState

func state_input(_event :InputEvent):
	pass

func state_process(_delta :float):
	pass

func on_entered():
	playback.travel("Hit")
	character.velocity = Vector2.ZERO
	character.freeze = true
	
func on_exited():
	pass
