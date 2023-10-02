extends RigidBody2D
class_name spike_head

@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_area_collision = $"Hit Area/CollisionShape2D"
var hit_animation :String

signal got_hit

var hit_points = 2

func _ready() -> void:
	hit_animation = "Hit"

func _on_hit_area_body_entered(body: Node2D) -> void:
	print(body.name + " entered")
	
	if body is Player && hit_points > 0:
		hit_points -= 1
		print("player on rock head")
		animated_sprite.play(hit_animation)
		emit_signal("got_hit")
		$"Hit Sound".play()
		
		if body.direction == 0:
			body.direction = 1

		body.velocity.y = -200
		
		if hit_points == 0:
			call_deferred("die")

func _on_hit_area_body_exited(body: Node2D) -> void:
	print(body.name + " exited")
	hit_area_collision.set_deferred("disabled", true)
	if body is Player:
		await get_tree().create_timer(3).timeout
		animated_sprite.play("Blink")
		hit_area_collision.set_deferred("disabled", false)
		await get_tree().create_timer(0.5).timeout
		animated_sprite.play("Idle")

func die():
	gravity_scale = 1
	freeze = false
