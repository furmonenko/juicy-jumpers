extends ParallaxBackground

@export var SCROLL_SPEED = 20

@onready var sprite = $ParallaxLayer/Sprite2D

func _physics_process(delta: float) -> void:
	sprite.region_rect.position += Vector2(SCROLL_SPEED, SCROLL_SPEED) * delta
