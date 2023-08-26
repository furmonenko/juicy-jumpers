extends Node2D

@onready var hit_area = $HitArea
@onready var anim_sprite = $HitArea/AnimatedSprite2D

signal player_entered(player)

func _ready() -> void:
	hit_area.connect("body_entered", _on_area_2d_body_entered)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_entered", body)

func _on_blink_timer_timeout() -> void:
	anim_sprite.play("Blink")
