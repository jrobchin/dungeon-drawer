extends Node

@export var room: Room
@export var card_manager: CardManager
@export var state_initializer: StateInitializer
@export var state_manager: StateManager
@export var drawDeck: Deck
@export var game_state_machine: StateMachine


func _on_debug_gui_deal_cards() -> void:
	game_state_machine.set_state(GameState.DEALING_ROOM)


func _on_debug_gui_reset() -> void:
	game_state_machine.set_state(GameState.INITIALIZING)


func _on_debug_gui_health_changed(value: int) -> void:
	state_manager.player_health = value


func _on_debug_gui_shuffle_deck() -> void:
	drawDeck.shuffle_deck()


func _on_debug_gui_set_room_draggable() -> void:
	room.set_draggable(true)


func _on_debug_gui_set_room_not_draggable() -> void:
	room.set_draggable(false)
