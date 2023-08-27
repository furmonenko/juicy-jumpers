extends Control

class_name HUD

@export var score_res : Resource

@onready var score_label = $"Score Label"
@onready var needed_score_label = $"Needed Score"

func set_score_label(new_score):
	score_label.text = "Score: " +  str(new_score)

func set_needed_score_label(needed_score):
	needed_score_label.text = "NEEDED: " + str(needed_score)
