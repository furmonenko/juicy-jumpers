extends Node2D

class_name Saw

@onready var anim_sprite = $Area2D/AnimatedSprite2D

func _ready() -> void:
	anim_sprite.play_backwards()
