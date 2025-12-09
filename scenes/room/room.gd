class_name Room extends Node2D

var cards: Array = [null, null, null, null]

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

func can_add_card() -> bool:
	var num_cards = _num_cards()
	Debug.print_info("Number of cards in room: %d" % num_cards)
	return num_cards < cards.size()

## Adds a card to the room. Returns the index where the card was added, or -1 if the room is full.
func add_card(card: Cards.Card) -> int:
	if not can_add_card():
		Debug.print_info("Cannot add card, room is full.")
		return -1

	var first_empty_index = _first_empty_index()
	if first_empty_index == -1:
		printerr("Error: No empty index found, but room is not full?")

	Debug.print_info("Adding card to room: %s of %s" % [card.rank, card.suit])
	cards.append(card)

	Debug.print_info("Cards: %s" % cards)

	return first_empty_index
