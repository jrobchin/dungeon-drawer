extends Node

const CARD_PLACEMENT_OFFSET = 10

@export var discard_deck: Deck
@export var room: Room

@onready var player_turn: PlayerTurn = get_parent() as PlayerTurn


func _equip_weapon(card_drop: CardDrop, card_node: CardNode) -> bool:
	Debug.print_info("Trying to equip %s on %s" % [card_node, card_drop])

	# Card must come from the room
	if card_node.status != Cards.STATUS.ROOM:
		Debug.print_info("Did not equip since the card is not in the room")
		return false

	# Card must be a diamond
	if !Cards.is_weapon(card_node.card):
		Debug.print_info("Did not equip since the card is not a diamond")
		return false

	Debug.print_info("Equipping weapon")
	# Clear out the current weapon slot
	if card_drop.card_nodes.size() > 0:
		_discard_weapon(card_drop)

	# Move the card and lock it
	room.remove_card(card_node)
	card_drop.add_card(card_node)
	card_node.global_position = card_drop.global_position
	card_node.draggable = false
	card_node.status = Cards.STATUS.WEAPON

	return true


func _discard_weapon(card_drop: CardDrop) -> void:
	var equipped_cards = card_drop.card_nodes.duplicate()
	card_drop.remove_cards()

	for card in equipped_cards:
		discard_deck.add_card(card)

	return


func _attack_monster(card_drop: CardDrop, card_node: CardNode) -> bool:
	Debug.print_info("Trying to attack %s on %s" % [card_node, card_drop])

	# Card must come from the room
	if card_node.status != Cards.STATUS.ROOM:
		Debug.print_info("Did not attack since the card is not in the room")
		return false

	# Card must be a monster
	if !Cards.is_monster(card_node.card):
		Debug.print_info("Did not attack since the card is not a monster")
		return false

	var equipped_weapon = _get_equipped_weapon(card_drop)
	var last_monster_defeated = _get_last_monster_defeated(card_drop)

	# Can only attack monsters if a weapon is equipped
	if equipped_weapon == null:
		Debug.print_info("Did not attack since no weapon is equipped")
		return false

	# Can only attack monsters if the last monster attacked is a higher rank
	if last_monster_defeated != null and last_monster_defeated.card.rank < card_node.card.rank:
		Debug.print_info("Did not attack since the last monster defeated has a lower rank")
		return false

	# Calculate and apply damage to health
	var damage = max(card_node.card.rank - equipped_weapon.card.rank, 0)
	Store.player_health = max(Store.player_health - damage, 0)

	Debug.print_info("Attacked monster and took %s damage" % damage)

	# Add card to the weapon stack
	room.remove_card(card_node)
	card_drop.add_card(card_node)
	card_node.global_position = _calculate_card_position(card_drop)
	card_node.draggable = false
	card_node.status = Cards.STATUS.DEFEATED_MONSTER

	return true


func _get_equipped_weapon(card_drop: CardDrop) -> CardNode:
	if card_drop.card_nodes.size() == 0:
		return null

	return card_drop.card_nodes[0]


func _get_last_monster_defeated(card_drop: CardDrop) -> CardNode:
	if card_drop.card_nodes.size() < 2:
		return null

	return card_drop.card_nodes[-1]


func _calculate_card_position(card_drop: CardDrop) -> Vector2:
	return card_drop.global_position + Vector2(0, CARD_PLACEMENT_OFFSET * (card_drop.card_nodes.size() - 1))


func _on_weapon_card_drop_node_dropped(droppable_area: DroppableArea, node: Node2D) -> void:
	if !player_turn.is_active:
		return

	if node is CardNode:
		var card_node = node as CardNode

		Debug.print_info("Trying to drop %s on %s" % [card_node, droppable_area])
		if _equip_weapon(droppable_area, card_node):
			return

		if _attack_monster(droppable_area, card_node):
			return

		card_node.put_back()
