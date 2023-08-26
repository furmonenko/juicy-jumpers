extends Node2D
class_name Trap

@onready var hit_area = $HitArea

signal player_entered(player)

func _ready() -> void:
	hit_area.connect("body_entered", _on_area_2d_body_entered)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_entered", body)
