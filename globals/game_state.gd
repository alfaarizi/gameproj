extends Node

enum State { EXPLORING, UI_NAVIGATION, INTERACTING }

signal state_changed(new_state: State)
var current_state: State = State.EXPLORING

func change_state(new_state: State) -> void:
	if current_state != new_state:
		current_state = new_state
		state_changed.emit(new_state)
