extends Node

@export var discard_deck: Deck
@export var room: Room


func _equip_weapon(card_drop: CardDrop, card_node: CardNode) -> bool:
	Debug.print_info("Trying to equip %s on %s" % [card_node, card_drop])

	# Card must come from the room
	if card_node.status != Cards.STATUS.ROOM:
		return false

	# Card must be a diamond
	if card_node.card.suit != Cards.Suit.DIAMONDS:
		return false

	# Clear out the current weapon slot
	if card_drop.card_nodes.size() > 0:
		_discard_weapon(card_drop)

	# Move the card and lock it
	room.remove_card(card_node)
	card_drop.add_card(card_node)
	card_node.global_position = card_drop.global_position
	card_node.draggable = false

	return true


func _discard_weapon(card_drop: CardDrop) -> void:
	var equipped_cards = card_drop.card_nodes.duplicate()
	card_drop.remove_cards()

	for card in equipped_cards:
		discard_deck.add_card(card.card)

	return


func _on_weapon_card_drop_node_dropped(droppable_area: DroppableArea, node: Node2D) -> void:
	if node is CardNode:
		var card_node = node as CardNode

		Debug.print_info("Trying to drop %s on %s" % [card_node, droppable_area])
		if _equip_weapon(droppable_area, card_node):
			return

		card_node.put_back()
