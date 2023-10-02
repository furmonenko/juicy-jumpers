extends Node2D
class_name SceneManager

@onready var main_menu_scene = load("res://Scenes/UI/main_menu.tscn")
@onready var level_ended_scene = load("res://Scenes/UI/level_ended_scene.tscn")
@onready var player_stats = load("res://Resources/player_stats.tres")
@onready var escape_menu_scene = load("res://Scenes/UI/escape_menu.tscn")
@onready var background_music = load("res://Sounds/lady-of-the-80x27s-128379.mp3")

var main_menu :MainMenu
var level_ended_screen :LevelEndedScene
var level_scenes_array :Dictionary
var levels_array :Dictionary
var levels_num = 5
var current_level
var level_index :int
var escape_menu :EscapeMenu
var escape_menu_opened :bool = false
var can_open_escape_menu: bool = false

func _ready() -> void:
	for i in levels_num:
		level_scenes_array[i] = load("res://Scenes/Levels/level_0" + str(i + 1) + ".tscn")
	for i in levels_num:
		levels_array[i] = level_scenes_array[i].instantiate()
		levels_array[i].connect("player_died", _on_player_died)
		levels_array[i].connect("level_completed", _on_level_completed)
		levels_array[i].connect("game_finished", _on_game_finished)
		
	current_level = levels_array[level_index]
	create_main_menu()
	
	var background_music_player = AudioStreamPlayer2D.new()
	background_music_player.stream = background_music
	background_music_player.volume_db = -30
	add_child(background_music_player)
	AudioPlayer.play_sound(background_music_player)

func start_game():
	level_index = 0
	player_stats.HP = 3
	create_level_ended_screen()
	main_menu.queue_free()

func _on_player_died():
	current_level.queue_free()
	create_level_ended_screen()
	
func _on_level_completed():
	if level_index == 4:
		current_level.queue_free()
		create_main_menu()
	else:
		current_level.queue_free()
		create_level_ended_screen()
		level_index += 1
	
func _on_game_finished():
	current_level.queue_free()
	create_main_menu()

func _on_level_ended_screen_finished():
	create_level(level_index)

func create_level_ended_screen():
	can_open_escape_menu = false
	level_ended_screen = level_ended_scene.instantiate()
	level_ended_screen.connect("level_ended_screen_ended", _on_level_ended_screen_finished)
	add_child(level_ended_screen)
	level_ended_screen.update_hearts()

func create_level(level_index):
	levels_array[level_index] = level_scenes_array[level_index].instantiate()
	current_level = levels_array[level_index]
	
	current_level.connect("player_died", _on_player_died)
	current_level.connect("level_completed", _on_level_completed)
	current_level.connect("game_finished", _on_game_finished)
	
	add_child(current_level)
	can_open_escape_menu = true

func create_main_menu():
	can_open_escape_menu = false
	main_menu = main_menu_scene.instantiate()
	add_child(main_menu)
	main_menu.connect("play_game_button_pressed", start_game)

func enter_escape_menu():
	pass
#	if !escape_menu_opened && can_open_escape_menu:
#		escape_menu = escape_menu_scene.instantiate()
#		add_child(escape_menu)
#		escape_menu_opened = true
#		escape_menu.connect("change_level", _on_level_changed)
#	elif escape_menu_opened:
#		escape_menu.call_deferred("queue_free")
#		escape_menu_opened = false
#	elif !can_open_escape_menu:
#		return

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		enter_escape_menu()
	if Input.is_action_just_pressed("Restart Level"):
		if current_level:
			var temp_level = current_level
			current_level.queue_free()

func _on_level_changed(new_level):
	current_level.queue_free()
	level_index = new_level.level_index 
	create_level(level_index)
