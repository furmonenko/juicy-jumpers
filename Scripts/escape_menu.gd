extends Control
class_name EscapeMenu

@onready var buttons = $Buttons
@onready var buttons_array = buttons.get_children()

var progress_res :Progress = Progress.new()

signal change_level(level)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Save"):
		SaveGame.save_progress()
		

func _ready() -> void:
	SaveGame.verify_save_dir()
	for button in buttons.get_children():
		button.connect("level_button_pressed", _on_level_button_pressed)
		
func _on_level_button_pressed(level_scene):
	var level = level_scene.instantiate()
	emit_signal("change_level", level)
