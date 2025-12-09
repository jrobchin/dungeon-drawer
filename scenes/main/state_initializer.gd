extends Node

@export var deck: Deck
@export var room: Room


func _on_debug_gui_reset() -> void:
	initialize_game_state()


func _ready() -> void:
	initialize_game_state()


func initialize_game_state() -> void:
	deck.initialize()
	deck.shuffle_deck()

	room.initialize()
