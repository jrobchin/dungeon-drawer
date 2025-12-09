extends Label

@export var deck: Deck

var n_cards: int = 0

func _process(_delta: float) -> void:
	if deck.cards.size() != n_cards:
		n_cards = deck.cards.size()
		text = str(n_cards)
