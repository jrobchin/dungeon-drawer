class_name Room
extends Node2D

var cards: Array[CardNode]


func _num_cards() -> int:
	var count: int = 0
	for card in cards:
		if card != null:
			count += 1
	return count


func _first_empty_index() -> int:
	for i in range(cards.size()):
		if cards[i] == null:
			return i
	return -1


func initialize() -> void:
	for i in range(cards.size()):
		if cards[i] != null:
			cards[i].queue_free()

	cards = [null, null, null, null]
	Debug.print_info("Room initialized.")


func can_add_card() -> bool:
	var num_cards = _num_cards()
	Debug.print_info("Number of cards in room: %d" % num_cards)
	return num_cards < cards.size()


## Adds a card to the room. Returns the index where the card was added, or -1 if the room is full.
func add_card(card_node: CardNode) -> int:
	if not can_add_card():
		Debug.print_info("Cannot add card_node, room is full.")
		return -1

	var first_empty_index = _first_empty_index()
	if first_empty_index == -1:
		printerr("Error: No empty index found, but room is not full?")

	Debug.print_info(
		"Adding card to room: %s of %s" % [
			Cards.rank_to_string(card_node.card.rank),
			Cards.suit_to_string(card_node.card.suit),
		],
	)
	cards[first_empty_index] = card_node

	add_child(card_node)

	Debug.print_info("Cards: " + str(cards))

	return first_empty_index
