extends Control

class_name HUD

@export var score_res : Resource

@onready var score_label = $Label

func set_score_label(new_score):
	score_label.text = "Score: " +  str(new_score)
