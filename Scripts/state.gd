extends Node
class_name State

@export var can_move :bool
@export var next_state :State


var playback :AnimationNodeStateMachinePlayback
var character :CharacterBody2D
var state_finished: bool

func state_input(_event :InputEvent):
	pass

func state_process(_delta :float):
	pass

func on_entered():
	pass
	
func on_exited():
	pass

func is_state_finished():
	return state_finished
