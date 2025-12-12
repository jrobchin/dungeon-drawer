extends Node

@export var discard: Deck


func _equip_weapon(card_drop: CardDrop, card_node: CardNode) -> bool:
	Debug.print_info("Trying to equip %s on %s" % [card_node, card_drop])
	if card_node.card.suit != Cards.Suit.DIAMONDS:
		return false

	if card_drop.card_nodes.size() > 0:
		_discard_weapon(card_drop)

	return true


func _discard_weapon(card_drop: CardDrop) -> void:
	Debug.print_info("Discarding weapon")
	var equipped_cards = card_drop.card_nodes
	card_drop.remove_cards()

	return


func _on_weapon_card_drop_node_dropped(droppable_area: DroppableArea, node: Node2D) -> void:
	if node is CardNode:
		var card_node = node as CardNode

		Debug.print_info("Trying to drop %s on %s" % [card_node, droppable_area])
		if _equip_weapon(droppable_area, card_node):
			return

		card_node.put_back()
