extends CharacterBody2D
class_name Player

@onready var anim_tree = $AnimationTree
@onready var anim_sprite = $AnimatedSprite2D
@onready var state_machine :StateMachine = $StateMachine
@onready var collision_shape = $CollisionShape2D
@onready var footstep_scene = preload("res://Scenes/Visual Effects/footstep_particle.tscn")

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
var should_fly :bool = false

signal player_died

func _ready() -> void:
	anim_tree.active = true
	playback = anim_tree["parameters/playback"]

func _physics_process(_delta: float) -> void:
	if freeze:
		return
	
	if should_fly:
		velocity.y = -200
	
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

func jump(jump_force, sfx = $"Sound Effects/Jump"):
	velocity.y = jump_force
	state_machine.switch_state($StateMachine/AirState)
	sfx.play()

func wall_jump():
	direction = -direction
	
	if direction == 0:
		if anim_sprite.flip_h == true:
			direction = 1
		elif anim_sprite.flip_h == false:
			direction = -1
	
	velocity.x = 200 * direction
	velocity.y = WALL_JUMP_FORCE
	# $"Sound Effects/Jump".play()
	AudioPlayer.play_sound($"Sound Effects/Jump")

func hit():
	state_machine.switch_state($StateMachine/HitState)
	AudioPlayer.play_sound($"Sound Effects/Death")

func _on_hit_ended():
	emit_signal("player_died")

func get_player_score():
	return points

func add_points(added_points):
	points += added_points

func _on_hit_area_area_entered(area: Area2D) -> void:
	print(area.name)
	hit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Move Down"):
		global_position.y += 1

func create_foot_step():
	if is_on_floor():
		var footstep = footstep_scene.instantiate()
		add_child(footstep)
		footstep.global_position = $Marker2D.global_position

func play_footstep_sound():
	AudioPlayer.play_sound($"Sound Effects/Footsteps")
