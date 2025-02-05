extends Control

@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	GameState.state_changed.connect(_on_state_change)
	_on_state_change(GameState.current_state)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_selection"):
		if GameState.current_state in [GameState.State.EXPLORING, GameState.State.UI_NAVIGATION]:
			player.player_camera.hud.toggle_hud()
	elif event.is_action_pressed("skip_dialogue"):
		if GameState.current_state == GameState.State.EXPLORING:
			player.player_camera.dialogue_hud.start_dialogue()

func _on_state_change(new_state: GameState.State) -> void:
	print(new_state)
	match new_state:
		GameState.State.EXPLORING:
			player.set_move_allowed(true)
		GameState.State.UI_NAVIGATION, GameState.State.INTERACTING:
			player.set_move_allowed(false)
