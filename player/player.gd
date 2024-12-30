extends CharacterBody2D

@export var max_speed := 500.0
@export_range(0.0, 1.0) var diagonal_speed_percent := 0.85
@export_range(0.0, 1.0) var running_speed_percent := 0.8
@export var acceleration := 1280.0
@export var deceleration := 1280.0

const UP_LEFT := Vector2.UP + Vector2.LEFT
const UP_RIGHT := Vector2.UP + Vector2.RIGHT
const DOWN_LEFT := Vector2.DOWN + Vector2.LEFT
const DOWN_RIGHT := Vector2.DOWN + Vector2.RIGHT

@onready var _input_action := ""
@onready var _animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var _gpu_particles_2d: GPUParticles2D = %GPUParticles2D

func	 _ready() -> void:
	scale = Vector2(6, 6)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction_discrete := direction.sign()
	var current_max_speed := max_speed
	match direction_discrete:
		Vector2.RIGHT, Vector2.LEFT:
			_input_action = "move_right" 
		Vector2.UP:
			_input_action = "move_up"
		Vector2.DOWN:
			_input_action = "move_down"
		UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT:
			_input_action = _input_action
			current_max_speed = max_speed * diagonal_speed_percent
		_:
			_animated_sprite_2d.frame = 0
			
	_animated_sprite_2d.play(_input_action)
	
	if direction.length() > 0.0:	
		_animated_sprite_2d.flip_h = direction.x < 0.0
		var desired_velovity := direction * current_max_speed
		var current_speed_percent := velocity.length() / current_max_speed
		_animated_sprite_2d.speed_scale = (
			1.5 
			if current_speed_percent > running_speed_percent
			else 1.0
		)
		velocity = velocity.move_toward(desired_velovity, acceleration * _delta)
		_gpu_particles_2d.emitting = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * _delta)
		_gpu_particles_2d.emitting = false
	move_and_slide()	
