extends Node2D

@onready var collectables = $Items
@onready var traps = $Traps
@onready var player = $Player
@onready var end_point = $EndPoint
@onready var spawn_position = $SpawnPosition

@export var next_level : PackedScene
@export var score_res : Resource
@export var level_index :int

var player_stats :PlayerStats = load("res://Resources/player_stats.tres")
var confetti_scene = load("res://Scenes/Visual Effects/confetti.tscn")
var escape_menu_scene = load("res://Scenes/UI/escape_menu.tscn")

var escape_menu :EscapeMenu
var item_count : int
var has_already_won :bool = false
var item_sfx :AudioStreamPlayer2D

signal level_completed
signal player_died
signal game_finished

func _ready() -> void:
	SaveGame.progress_res.finished_levels[level_index] = true
	
	player_stats.connect("no_hp_left", _on_player_died)
	player.connect("player_died", _on_player_died)
	escape_menu = escape_menu_scene.instantiate()
	escape_menu.visible = false
	$UI.add_child(escape_menu)

	for item in collectables.get_children():
		item.connect("item_picked_up", _on_item_picked_up)

func _physics_process(delta: float) -> void:
	if collectables.get_children().is_empty() && !has_already_won:
		has_already_won = true
		end_point.spawn()

func _on_item_picked_up(points):	item_count -= 1

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("Pause"):
	#	enter_escape_menu()
	if event.is_action_pressed("Restart Level"):
		get_tree().reload_current_scene()

func _on_end_point_player_entered(_body) -> void:
	await get_tree().create_timer(2).timeout
	SaveGame.save_progress()
	
	var confetti = confetti_scene.instantiate()
	add_child(confetti)
	$"Sounds/Confetti Sounds".play()
	
	await get_tree().create_timer(4).timeout
	emit_signal("level_completed")

func _on_player_died():
	if player_stats.HP > 1:
		player_stats.decrease_health()
		emit_signal("player_died")
	elif player_stats.HP:
		emit_signal("game_finished")
