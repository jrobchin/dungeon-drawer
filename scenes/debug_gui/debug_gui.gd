extends Control

@export var game_state_machine: StateMachine

signal reset
signal deal_cards
signal shuffle_deck
signal health_changed(value: int)
signal set_room_draggable
signal set_room_not_draggable
signal toggle_hide_cards

var values: Dictionary = { }


func _process(_delta: float) -> void:
	_update_values()


func _update_values() -> void:
	values["game_state_machine.state.name"] = game_state_machine.state.name
	values["Store.is_dragging"] = Store.is_dragging
	if Store.dragging_node == null:
		values["Store.dragging_node.name"] = "null"
	else:
		values["Store.dragging_node.name"] = Store.dragging_node.name

	values["Store.player_turn"] = Store.player_turn
	values["Store.player_move"] = Store.player_move

	# Build values string
	var value_text: String = ""
	for key in values:
		value_text += "%s: %s\n" % [key, values[key]]

	%ValuesLabel.text = value_text


func _on_deal_cards_button_up() -> void:
	deal_cards.emit()


func _on_shuffle_deck_button_up() -> void:
	shuffle_deck.emit()


func _on_reset_button_up() -> void:
	reset.emit()


func _on_set_health_text_submitted(new_text: String) -> void:
	if !new_text.is_valid_int():
		printerr("Health can only be set to an int")

	health_changed.emit(int(new_text))


func _on_set_room_draggable_button_up() -> void:
	set_room_draggable.emit()


func _on_set_room_not_draggable_button_up() -> void:
	set_room_not_draggable.emit()


func _on_toggle_hide_cards_button_up() -> void:
	toggle_hide_cards.emit()
