extends CharacterBody2D

class_name Enemy

@export var SPEED = 40
@export var direction = 1

@onready var animated_sprite = $AnimatedSprite2D

var can_move = true
var dead = false

var hit_animation :String

func _physics_process(delta: float) -> void:
	pass

func die():
	$"Deadly Area/CollisionShape2D".disabled = true
	animated_sprite.play(hit_animation)
	can_move = false
	
	await get_tree().create_timer(0.2).timeout
	call_deferred("queue_free")

func _on_hit_area_body_entered(body: Node2D) -> void:
	body.velocity.y = -200
	call_deferred("die")
