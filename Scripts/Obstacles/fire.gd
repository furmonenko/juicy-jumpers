extends Node2D

@onready var animated_spite = $AnimatedSprite2D

func _ready() -> void:
	$"Hit Area/CollisionShape2D".disabled = true

func _on_turn_on_area_body_entered(body: Node2D) -> void:
	if body is Player:
		turn_on_fire()

func turn_on_fire():
	$"Hit Area/CollisionShape2D".set_deferred("disabled", false)
	animated_spite.play("On")
	
	await get_tree().create_timer(3).timeout
	animated_spite.play("Off")
	$"Hit Area/CollisionShape2D".set_deferred("disabled", true)
