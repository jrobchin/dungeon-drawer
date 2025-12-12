extends Node

@export var room: Room
@export var card_manager: CardManager
@export var state_initializer: StateInitializer
@export var drawDeck: Deck
@export var game_state_machine: StateMachine
@export var card_tree: CardTree

var card_hidden_states: Dictionary = { }


func _on_debug_gui_deal_cards() -> void:
	game_state_machine.set_state(GameState.DEALING_ROOM)


func _on_debug_gui_reset() -> void:
	game_state_machine.set_state(GameState.INITIALIZING)


func _on_debug_gui_health_changed(value: int) -> void:
	Store.player_health = value


func _on_debug_gui_shuffle_deck() -> void:
	drawDeck.shuffle_deck()


func _on_debug_gui_set_room_draggable() -> void:
	room.set_draggable(true)


func _on_debug_gui_set_room_not_draggable() -> void:
	room.set_draggable(false)


func _on_debug_gui_toggle_hide_cards() -> void:
	card_tree.visible = !card_tree.visible
