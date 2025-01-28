class_name PlayerContainer extends VBoxContainer

@onready var player_profile_texture: TextureRect = %PlayerProfileTexture
@onready var player_health_slider: HSlider = %PlayerHealthSlider
@onready var player_energy_slider: HSlider = %PlayerEnergySlider
@onready var player_status_container: Array[TextureRect] = [
	%Status1Texture, %Status2Texture, %Status3Texture, 
	%Status4Texture, %Status5Texture, %Status6Texture, 
	%Status7Texture, %Status8Texture, %Status9Texture, 
	%Status10Texture
]

const PLAYER_STATUS_MAX := 10
@export var _current_player_status: Array[Texture] = []

func _ready() -> void:
	for status in player_status_container:
		status.visible = false

func add_status(_status_texture: Texture2D) -> void:
	if _current_player_status.size() < PLAYER_STATUS_MAX:
		_current_player_status.append(_status_texture)
		_update_status_textures()

func remove_status(_status_texture: Texture2D) -> void:
	if _status_texture in _current_player_status:
		_current_player_status.erase(_status_texture)
		_update_status_textures()

func _update_status_textures() -> void:
	for idx in range(player_status_container.size()):
		if idx < _current_player_status.size():
			player_status_container[idx].texture = _current_player_status[idx]
			player_status_container[idx].visible = true
		else:
			player_status_container[idx].texture = null
			player_status_container[idx].visible = true
