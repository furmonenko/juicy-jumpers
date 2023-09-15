extends Node2D

@onready var animated_sprite = $JumpArea/AnimatedSprite2D

var is_colliding = false
var player :Player = null

func _on_jump_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("entered")
		animated_sprite.play("On")
		player = body
		player.should_fly = true


func _on_collision_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player = body
		player.should_fly = false
