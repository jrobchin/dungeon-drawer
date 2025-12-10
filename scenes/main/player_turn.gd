extends GameState

@export var state_manager: StateManager


func enter(_previous_state_path: String, _data := { }) -> void:
	state_manager.player_turn += 1
