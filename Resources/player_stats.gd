extends Resource
class_name PlayerStats

@export var HP :int = 3

signal no_hp_left

func decrease_health():
	HP -= 1
	
	#if HP <= 0:
	#	emit_signal("no_hp_left")
