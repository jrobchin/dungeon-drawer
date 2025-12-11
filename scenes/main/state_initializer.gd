class_name StateInitializer
extends Node

@export var deck: Deck
@export var room: Room
@export var state_manager: StateManager
@export var card_tree: CardTree
@export var game_state_machine: StateMachine


func _on_debug_gui_reset() -> void:
	game_state_machine.set_state(GameState.INITIALIZING)


func initialize_game_state() -> void:
	deck.initialize()
	deck.shuffle_deck()

	room.initialize()

	card_tree.initialize()

	state_manager.initialize()
