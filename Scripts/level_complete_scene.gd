extends Node2D

@onready var next_lvl_btn = $"Control/Next Level Button"
@onready var exit_btn = $"Control/Exit Button"
@onready var score_lvl = $"Control/Your Score"

@export var score_res : Resource


func _ready() -> void:
	set_score(score_res.get_score())

#func create_scene(next_level, score):
#	next_lvl_btn.connect("pressed", _on_next_btn_lvl_pressed)
	
#func _on_next_btn_lvl_pressed():
#	get_tree().change_scene_to_packed(score_res.next_lvl)
	
func set_score(new_score):
	score_lvl.text = "Your score: " + str(new_score)


func _on_next_level_button_pressed() -> void:
		get_tree().change_scene_to_packed(score_res.next_level)
