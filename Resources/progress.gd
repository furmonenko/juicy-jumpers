extends Resource
class_name Progress

@export var finished_levels :Dictionary

var levels_number = 5

func init():
	print("ready")
	finished_levels [0] = true
	var i = 1
	
	while i < levels_number:
		finished_levels [i] = false
		i += 1
