extends Sprite2D

func _ready() -> void:
	var parent = get_parent()
	assert(parent is Deck, "%s must be a child of a Deck node" % self)

	parent = parent as Deck
	parent.cards_changed.connect(_on_deck_cards_changed)


func _on_deck_cards_changed(deck: Deck) -> void:
	visible = deck.cards.size() == 0
