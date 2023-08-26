extends Node2D

@onready var area = $Area2D
@onready var animated_sprite = $Area2D/AnimatedSprite2D

@export var JUMP_FORCE = -800

signal player_on_jump_pad(jump_force)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite.play("Jump")
		body.jump(JUMP_FORCE)
