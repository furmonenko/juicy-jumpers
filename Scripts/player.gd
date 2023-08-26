extends CharacterBody2D
class_name Player

@onready var anim_tree = $AnimationTree
@onready var anim_sprite = $AnimatedSprite2D
@onready var state_machine :StateMachine = $StateMachine
@onready var collision_shape = $CollisionShape2D

@export var GRAVITY = 40
@export var SPEED = 200
@export var JUMP_FORCE = -400
@export var WALL_JUMP_FORCE = -450
@export var ACCELERATION = 30

var playback :AnimationNodeStateMachinePlayback
var was_on_floor = false
var direction : float
var points : int
var freeze = false
var game_over = false

signal player_died

func _ready() -> void:
	anim_tree.active = true
	playback = anim_tree["parameters/playback"]

func _physics_process(_delta: float) -> void:
	if freeze:
		return
	
	if !is_on_floor():
		velocity.y += GRAVITY
	
	if state_machine.check_if_can_move():
		direction = Input.get_axis("Move Left", "Move Right")
		
		if direction != 0:
			velocity.x += ACCELERATION * direction
		else:
			velocity.x = lerpf(velocity.x, 0, 0.6)
			
		velocity.x = clampf(velocity.x, -SPEED, SPEED)

	was_on_floor = is_on_floor()
	
	update_animation_parameters()
	move_and_slide()

func update_animation_parameters():
	if !is_on_wall():
		if direction != 0:
			anim_sprite.flip_h = (direction == -1)
		
	anim_tree.set("parameters/Idle & Walk/blend_position", direction)

func jump(jump_force):
	velocity.y = jump_force
	state_machine.switch_state($StateMachine/AirState)
	
func wall_jump():
	direction = -direction
	
	if direction == 0:
		if anim_sprite.flip_h == true:
			direction = 1
		elif anim_sprite.flip_h == false:
			direction = -1
	
	velocity.x = 200 * direction
	velocity.y = WALL_JUMP_FORCE

func hit():
	state_machine.switch_state($StateMachine/HitState)

func _on_hit_ended():
	emit_signal("player_died")

func get_player_score():
	return points

func add_points(added_points):
	points += added_points

func _on_hit_area_area_entered(area: Area2D) -> void:
	print(area.name)
	hit()
