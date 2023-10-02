extends Node2D
class_name LevelEndedScene

@onready var player_stats :PlayerStats = load("res://Resources/player_stats.tres")
@onready var tips = $Control/Tips

var tip
var hearts_array :Array

signal level_ended_screen_ended

func _on_timer_timeout() -> void:
	$"Control/Panel/Player Sprite/AnimatedSprite2D".play("Disapear")
	$Timer.stop()
	await get_tree().create_timer(0.4).timeout
	emit_signal("level_ended_screen_ended")
	tip.visible = false
	queue_free()

func _ready() -> void:
	update_hearts()
	tip = tips.get_children().pick_random()
	tip.visible = true

func update_hearts():
	for i in $Control/Panel/Health.get_child_count():
		$Control/Panel/Health.get_child(i).visible = false
		
	for i in player_stats.HP:
		$Control/Panel/Health.get_child(i).visible = true
