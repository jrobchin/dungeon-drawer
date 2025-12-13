extends PlayerAbility

@export var room: Room
@export var draw_deck: Deck
@export var skip_button: Button

signal skipped_room


func _ready() -> void:
	super._ready()

	Store.player_turn_changed.connect(_on_player_turn_changed)
	Store.last_skipped_changed.connect(_on_last_skipped_changed)


func _skip_room() -> bool:
	Debug.print_info(
		"[%s] Trying to skip player_turn: %s, last_skipped: %s, diff: %s" % [
			self,
			Store.player_turn,
			Store.last_skipped,
			Store.player_turn - Store.last_skipped,
		],
	)
	if Store.player_turn - Store.last_skipped < 2:
		return false

	Store.last_skipped = Store.player_turn

	_put_room_cards_in_deck()

	skipped_room.emit()

	return true


func _put_room_cards_in_deck() -> void:
	Debug.print_info("[%s] Putting room cards in deck" % self)
	var room_cards = room.card_nodes.duplicate()
	room.initialize()

	for card in room_cards:
		draw_deck.add_card_to_bottom(card)


func _on_skip_button_up() -> void:
	if !is_players_turn():
		return

	if _skip_room():
		return


func _on_last_skipped_changed(_value: int):
	_update_can_skip()


func _on_player_turn_changed(_value: int):
	_update_can_skip()


func _update_can_skip():
	if Store.player_turn - Store.last_skipped < 2:
		skip_button.disabled = true

	skip_button.disabled = false
