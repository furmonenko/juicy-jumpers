extends Node
class_name StateMachine

@export var current_state :State
@export var character :CharacterBody2D
@export var animation_tree :AnimationTree

@onready var state_label = $"../Control/Label"

var state_array :Array[State]

func _ready() -> void:
	for child in get_children():
		if child is State:
			state_array.append(child)
			
			child.character = character
			child.playback = animation_tree["parameters/playback"]


func _input(event: InputEvent) -> void:
	current_state.state_input(event)


func _physics_process(delta: float) -> void:
	state_label.text = "State: " + current_state.name
	
	current_state.state_process(delta)
	
	if current_state.next_state:
		switch_state(current_state.next_state)


func check_if_can_move():
	if current_state:
		return current_state.can_move


func switch_state(next_state):
	if current_state:
		current_state.on_exited()
		current_state.next_state = null

	current_state = next_state
	current_state.on_entered()
