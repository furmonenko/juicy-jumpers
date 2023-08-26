extends Node2D

@onready var anim_player = $Area2D/AnimationPlayer
@onready var collision : CollisionShape2D = $Area2D/CollisionShape2D

signal player_entered(player)

func spawn():
	collision.disabled = true
	anim_player.play("Appear")

func has_spawned():
	collision.disabled = false
	anim_player.play("Flag Out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Flag Out":
		anim_player.play("Flag Idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_entered", body)
