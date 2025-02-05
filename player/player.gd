extends CharacterBody2D

const DEFAULT_MAX_SPEED := 700.0
const UP_LEFT := Vector2.UP + Vector2.LEFT
const UP_RIGHT := Vector2.UP + Vector2.RIGHT
const DOWN_LEFT := Vector2.DOWN + Vector2.LEFT
const DOWN_RIGHT := Vector2.DOWN + Vector2.RIGHT

@export var max_speed := DEFAULT_MAX_SPEED
@export_range(0.0, 1.0) var diagonal_speed_percent := 0.85
@export_range(0.0, 1.0) var running_speed_percent := 0.8
@export var acceleration := 2800.0
@export var deceleration := 2800.0

@onready var _move_action := ""
@onready var _move_allowed := true
@onready var _current_max_speed := max_speed
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var player_camera: PlayerCamera = %PlayerCamera

func	 _ready() -> void:
	scale = Vector2(6, 6)

func set_move_allowed(flag: bool) -> void:
	_move_allowed = flag
	gpu_particles_2d.emitting = flag
	if not _move_allowed and animated_sprite_2d.is_playing():
		animated_sprite_2d.stop()

func _physics_process(_delta: float) -> void:		
	if not _move_allowed:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction_discrete := direction.sign()
	_current_max_speed = max_speed
	match direction_discrete:
		Vector2.RIGHT, Vector2.LEFT:
			_move_action = "move_right" 
		Vector2.UP:
			_move_action = "move_up"
		Vector2.DOWN:
			_move_action = "move_down"
		UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT:
			_move_action = _move_action
			_current_max_speed = max_speed * diagonal_speed_percent
		_:
			animated_sprite_2d.frame = 0
			
	animated_sprite_2d.play(_move_action)
	
	if direction.length() > 0.0:	
		animated_sprite_2d.flip_h = direction.x < 0.0
		var desired_velovity := direction * _current_max_speed
		var current_speed_percent := velocity.length() / _current_max_speed
		animated_sprite_2d.speed_scale = (
			1.75
			if current_speed_percent > running_speed_percent
			else 1.0
		)
		velocity = velocity.move_toward(desired_velovity, acceleration * _delta)
		gpu_particles_2d.emitting = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * _delta)
		gpu_particles_2d.emitting = false
	move_and_slide()	
