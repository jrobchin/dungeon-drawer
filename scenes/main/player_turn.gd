class_name PlayerTurn
extends GameState

enum MOVES {
	EquipWeapon,
}

@export var room: Room
@export var card_tree: CardTree
@export var draw_deck: Deck

## Emitted when the game finishes.
signal game_complete(win: bool, points: int)

var is_active: bool = false


func _ready() -> void:
	Store.player_health_changed.connect(_on_player_health_changed)
	Store.player_move_changed.connect(_on_player_move_changed)


func enter(_previous_state_path: String, _data := { }) -> void:
	is_active = true

	Store.player_move = 0
	Store.used_health_potion = false

	room.set_draggable(true)


func exit() -> void:
	is_active = false

	Store.player_turn += 1

	card_tree.set_draggable(false)


func _calculate_loss_points() -> int:
	var points = 0
	for card in draw_deck.cards:
		if Cards.is_monster(card):
			points -= card.rank

	for card_node in room.get_card_nodes():
		if Cards.is_monster(card_node.card):
			points -= card_node.card.rank

	return points


func _calculate_win_points() -> int:
	return Store.player_health


func _on_player_health_changed(value: int):
	if value == 0:
		game_complete.emit(false, _calculate_loss_points())


func _on_player_move_changed(value: int):
	if room.is_empty() and draw_deck.cards.size() == 0:
		game_complete.emit(true, _calculate_win_points())

	if value >= Settings.total_player_moves:
		Debug.print_info("Player turn ended")
		finished.emit(GameState.DEALING_ROOM)


func _on_skip_ability_skipped_room() -> void:
	finished.emit(GameState.DEALING_ROOM)
