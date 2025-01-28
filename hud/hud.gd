extends CanvasLayer

@onready var player_container_1: PlayerContainer = %PlayerContainer1
@onready var player_container_2: PlayerContainer = %PlayerContainer2
@onready var player_container_3: PlayerContainer = %PlayerContainer3
@onready var player_container_4: PlayerContainer = %PlayerContainer4

const ICON = preload("res://icon.svg")

func _ready() -> void:
	player_container_1.add_status(ICON)
	player_container_2.add_status(ICON)
	player_container_2.add_status(ICON)
	player_container_4.add_status(ICON)
	player_container_4.add_status(ICON)
	player_container_3.add_status(ICON)
	player_container_4.remove_status(ICON)
