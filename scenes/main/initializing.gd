extends GameState

@export var state_initializer: StateInitializer


func enter(_previous_state_path: String, _data := { }) -> void:
	Debug.print_info("Entering %s state" % INITIALIZING)
	state_initializer.initialize_game_state()

	finished.emit(DEALING_ROOM)
