extends State

@export var state_initializer: StateInitializer


func enter(_previous_state_path: String, _data := { }) -> void:
	Debug.print_info("Entering INITIALIZING state")
	state_initializer.initialize_game_state()
