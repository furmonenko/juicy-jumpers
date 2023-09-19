extends Area2D

class_name Collectable

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

@export var ITEM_POINTS = 10

var item_sfx :AudioStreamPlayer2D
var item_pick_up_sound = load("res://Sounds/pickupCoin.wav")

signal item_picked_up(points)

func _ready() -> void:
	item_sfx = AudioStreamPlayer2D.new()
	item_sfx.stream = item_pick_up_sound
	add_child(item_sfx)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		anim_sprite.play("PickedUp")
		item_sfx.volume_db = -15
		AudioPlayer.play_sound(item_sfx)

func _on_animated_sprite_2d_animation_finished() -> void:
	emit_signal("item_picked_up", ITEM_POINTS)
	queue_free()

func get_item_points():
	return ITEM_POINTS
