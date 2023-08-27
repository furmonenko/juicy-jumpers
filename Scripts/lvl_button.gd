extends Button
class_name LevelButton

@export var level_scene :PackedScene

signal level_button_pressed(new_level_scene)

func _ready() -> void:
	connect("pressed", _on_button_pressed)
	
func _on_button_pressed():
	emit_signal("level_button_pressed", level_scene)
