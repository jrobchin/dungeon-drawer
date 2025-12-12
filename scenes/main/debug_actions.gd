extends Node

@export var card_manager: CardManager
@export var state_initializer: StateInitializer
@export var state_manager: StateManager
@export var deck: Deck


func _on_debug_gui_deal_card() -> void:
	await card_manager.deal_card()


func _on_debug_gui_reset() -> void:
	state_initializer.initialize_game_state()


func _on_debug_gui_health_changed(value: int) -> void:
	state_manager.player_health = value


func _on_debug_gui_shuffle_deck() -> void:
	deck.shuffle_deck()
