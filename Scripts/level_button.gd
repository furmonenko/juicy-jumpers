extends Button
class_name LevelBbutton

@export var level_scene :PackedScene
@export var level_index :int

var blue_buttons_folder :String = "res://Assets/Menu/Levels/"
var grey_buttons_folder :String = "res://Assets/Menu/Levels/Grey Buttons/" 

func _ready() -> void:
	if SaveGame.progress_res.finished_levels[level_index] == false:
		icon = load(grey_buttons_folder + "0" + str (level_index + 1) + ".png")
	else:
		icon = load(blue_buttons_folder + "0" + str (level_index + 1) + ".png")

func _on_pressed() -> void:
	if SaveGame.progress_res.finished_levels[level_index] == true:
		get_tree().change_scene_to_packed(level_scene)
