extends CanvasLayer

@onready var _hud: CanvasLayer = $"."

@onready var player_container_1: PlayerContainer = %PlayerContainer1
@onready var player_container_2: PlayerContainer = %PlayerContainer2
@onready var player_container_3: PlayerContainer = %PlayerContainer3
@onready var player_container_4: PlayerContainer = %PlayerContainer4
@onready var player_portrait: PlayerPortrait = %PlayerPortrait

func _ready() -> void:
	_hud.visible = false	
	_sample_display()
	
func toggle_hud() -> void:
	_hud.visible = not _hud.visible
	if _hud.visible:
		GameState.change_state(GameState.State.UI_NAVIGATION)
	else:
		GameState.change_state(GameState.State.EXPLORING)

func _sample_display() -> void:
	const ICON = preload("res://icon.svg")
	player_portrait.status_container.add_status(ICON)
	player_portrait.status_container.add_status(ICON)
	for i in randf_range(0,10):
		player_container_1.status_container.add_status(ICON)	
	for i in randf_range(0,10):
		player_container_2.status_container.add_status(ICON)	
	for i in randf_range(0,10):
		player_container_3.status_container.add_status(ICON)	
	for i in randf_range(0,10):
		player_container_4.status_container.add_status(ICON)	
