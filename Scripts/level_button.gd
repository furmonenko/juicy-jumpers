extends Button
class_name LevelBbutton

@export var level_scene :PackedScene

func _on_pressed() -> void:
	print("pressed")
	get_tree().change_scene_to_packed(level_scene)
