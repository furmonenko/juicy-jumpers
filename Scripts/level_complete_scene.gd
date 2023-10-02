extends Node2D
class_name MainMenu

@onready var play_game_btn = $"Control/Play Game Button"
@onready var exit_btn = $"Control/Exit Button"

signal play_game_button_pressed

func _ready() -> void:
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_play_game_button_pressed() -> void:
	emit_signal("play_game_button_pressed")
