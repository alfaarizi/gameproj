extends Control

@onready var hud: CanvasLayer = %Hud
@onready var player: CharacterBody2D = %Player

var toggle_selection := false

func _ready() -> void:
	hud.visible = false
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("player_selection"):
		toggle_selection = not toggle_selection
		player.max_speed = 0.0 if toggle_selection else player.DEFAULT_MAX_SPEED
	hud.visible = toggle_selection
