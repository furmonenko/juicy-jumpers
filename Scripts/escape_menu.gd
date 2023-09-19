extends Control
class_name EscapeMenu

@onready var buttons = $Buttons
@onready var buttons_array = buttons.get_children()

var progress_res :Progress = Progress.new()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Save"):
		SaveGame.save_progress()
		

func _ready() -> void:
	SaveGame.verify_save_dir()
	#progress_res = SaveGame.load_progress()
	pass

