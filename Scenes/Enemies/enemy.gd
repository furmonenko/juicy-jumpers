extends CharacterBody2D
class_name Enemy

@export var SPEED = 40

@onready var animated_sprite = $AnimatedSprite2D

var direction = 1
var can_move = true
var dead = false

func _physics_process(delta: float) -> void:
	if can_move:
		velocity.x = SPEED * direction
	
		if velocity != Vector2.ZERO:
			animated_sprite.play("Run")
			animated_sprite.flip_h = (direction == 1)
			move_and_slide()

func change_direction():
	animated_sprite.play("Idle")
	can_move = false
	
	await get_tree().create_timer(4).timeout
	
	direction = -direction
	can_move = true

func die():
	$"Deadly Area/CollisionShape2D".disabled = true
	animated_sprite.play("Hit")
	can_move = false
	
	await get_tree().create_timer(0.2).timeout
	call_deferred("queue_free")

func _on_hit_area_body_entered(body: Node2D) -> void:
	body.velocity.y = -200
	call_deferred("die")
