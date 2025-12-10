extends GameState

@export var card_manager: CardManager


func enter(previous_state_path: String, _data := { }) -> void:
	if previous_state_path == INITIALIZING:
		Debug.print_info("Dealing first cards to the room")

	var can_deal = true
	while can_deal:
		can_deal = await card_manager.deal_card()

	finished.emit(PLAYER_TURN)
