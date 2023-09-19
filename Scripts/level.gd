extends Node2D

@onready var collectables = $Items
@onready var traps = $Traps
@onready var player = $Player
@onready var end_point = $EndPoint
@onready var spawn_position = $SpawnPosition

@export var next_level : PackedScene
@export var score_res : Resource
@export var level_index :int

var level_complete_scene = preload("res://Scenes/level_complete_scene.tscn")
var escape_menu_scene = load("res://Scenes/UI/escape_menu.tscn")

var escape_menu :EscapeMenu
var item_count : int
var has_already_won :bool = false
var item_sfx :AudioStreamPlayer2D

func _ready() -> void:
	SaveGame.progress_res.finished_levels[level_index] = true
	
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
	if event.is_action_pressed("Pause"):
		enter_escape_menu()
	if event.is_action_pressed("Restart Level"):
		get_tree().reload_current_scene()

func enter_escape_menu():
	escape_menu.visible = !escape_menu.visible

func _on_end_point_player_entered(_body) -> void:
	await get_tree().create_timer(2).timeout
	score_res.set_next_level(next_level)
	SaveGame.save_progress()
	get_tree().change_scene_to_packed(level_complete_scene)

func _on_player_died():
	get_tree().reload_current_scene()
