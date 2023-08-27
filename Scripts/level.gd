extends Node2D

@onready var collectables = $Items
@onready var traps = $Traps
@onready var player = $Player
@onready var hud :HUD = $UI/HUD
@onready var end_point = $EndPoint
@onready var spawn_position = $SpawnPosition
# @onready var escape_menu = $"UI/Escape Menu"

@export var next_level : PackedScene
@export var score_res : Resource

var level_complete_scene = preload("res://Scenes/level_complete_scene.tscn")
var escape_menu_scene = load("res://Scenes/UI/escape_menu.tscn")

var escape_menu :EscapeMenu

var max_score : float
var score_to_finish : float
var item_count : int
var has_already_won :bool = false

func _ready() -> void:
	player.connect("player_died", _on_player_died)
	escape_menu = escape_menu_scene.instantiate()
	escape_menu.visible = false
	$UI.add_child(escape_menu)

	item_count = collectables.get_child_count()
	hud.set_score_label(player.get_player_score())

	for item in collectables.get_children():
		item.connect("item_picked_up", _on_item_picked_up)
		max_score += item.ITEM_POINTS

	score_to_finish = max_score * 0.8
	score_to_finish = score_to_finish - fmod(score_to_finish, 10.0)
	
	hud.set_needed_score_label(score_to_finish)

func _on_item_picked_up(points):
	player.add_points(points)
	hud.set_score_label(player.get_player_score())
	item_count -= 1
	score_res.set_score(player.get_player_score())

	if player.get_player_score() >= score_to_finish && !has_already_won:
		has_already_won = true
		end_point.spawn()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		enter_escape_menu()

func enter_escape_menu():
	escape_menu.visible = !escape_menu.visible

func _on_end_point_player_entered(_body) -> void:
	# player.complete_level()
	
	await get_tree().create_timer(2).timeout
	score_res.set_next_level(next_level)
	get_tree().change_scene_to_packed(level_complete_scene)

func _on_player_died():
	get_tree().reload_current_scene()

