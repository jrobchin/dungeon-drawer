extends Control

@export var game_state_machine: StateMachine

signal reset
signal deal_card
signal shuffle_deck
signal health_changed(value: int)

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

	var value_text: String = ""
	for key in values:
		value_text += "%s: %s\n" % [key, values[key]]

	%ValuesLabel.text = value_text


func _on_deal_card_button_up() -> void:
	deal_card.emit()


func _on_shuffle_deck_button_up() -> void:
	shuffle_deck.emit()


func _on_reset_button_up() -> void:
	reset.emit()


func _on_set_health_text_submitted(new_text: String) -> void:
	if !new_text.is_valid_int():
		printerr("Health can only be set to an int")

	health_changed.emit(int(new_text))
