extends Node2D
class_name BallOnChain

@onready var top_pin_joint = $PinJoint2D2
@onready var rock_head = $"Rock Head"

var dropped_chains :bool = false

func _ready() -> void:
	rock_head.connect("got_hit", drop_chains)
	$AudioStreamPlayer2D.play()
	
func drop_chains():
	if !dropped_chains:
		if top_pin_joint:
			top_pin_joint.queue_free()
			dropped_chains = true
			
			await get_tree().create_timer(1).timeout
			$"Spiked Ball".queue_free()
	else:
		await get_tree().create_timer(3).timeout
		queue_free()
