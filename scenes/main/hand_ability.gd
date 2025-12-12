extends PlayerAbility

@export var discard_deck: Deck
@export var room: Room


func _attack_monster(card_node: CardNode) -> bool:
	Debug.print_info("[%s] Trying to attack %s" % [self, card_node])

	# Card must come from the room
	if card_node.status != Cards.STATUS.ROOM:
		Debug.print_info("[%s] Did not attack since the card is not in the room" % self)
		return false

	# Card must be a monster
	if !Cards.is_monster(card_node.card):
		Debug.print_info("[%s] Did not attack since the card is not a monster" % self)
		return false

	# Calculate and apply damage to health
	var damage = card_node.card.rank
	Store.player_health = max(Store.player_health - damage, 0)

	Debug.print_info("[%s] Attacked monster and took %s damage" % [self, damage])

	# Discard card
	room.remove_card(card_node)
	discard_deck.add_card(card_node)

	return true


func _on_hand_card_drop_node_dropped(droppable_area: DroppableArea, node: Node2D) -> void:
	if !is_players_turn():
		return

	if node is CardNode:
		var card_node = node as CardNode

		Debug.print_info("[%s] Trying to drop %s on %s" % [self, card_node, droppable_area])

		if _attack_monster(card_node):
			return

		card_node.put_back()
