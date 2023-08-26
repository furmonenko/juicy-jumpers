extends Area2D

class_name Collectable

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

@export var ITEM_POINTS = 10

signal item_picked_up(points)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		anim_sprite.play("PickedUp")

func _on_animated_sprite_2d_animation_finished() -> void:
	emit_signal("item_picked_up", ITEM_POINTS)
	queue_free()

func get_item_points():
	return ITEM_POINTS
