extends PlayerAbility

const CARD_PLACEMENT_OFFSET = 9

@export var discard_deck: Deck
@export var room: Room


func _ready() -> void:
	super._ready()


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
	if last_monster_defeated != null and last_monster_defeated.card.rank <= card_node.card.rank:
		Debug.print_info("Did not attack since the last monster defeated has a lower rank")
		return false

	# Add card to the weapon stack
	room.remove_card(card_node)
	card_drop.add_card(card_node)
	card_node.global_position = _calculate_card_position(card_drop)
	card_node.draggable = false
	card_node.status = Cards.STATUS.DEFEATED_MONSTER

	# Calculate and apply damage to health
	var damage = max(card_node.card.rank - equipped_weapon.card.rank, 0)
	Store.player_health = max(Store.player_health - damage, 0)

	Debug.print_info("Attacked monster and took %s damage" % damage)

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


func _update_collision_shape(card_drop: CardDrop) -> void:
	if card_drop.card_nodes.size() == 0:
		card_drop.collision_shape.shape = card_drop.initial_collision_shape_shape
		return

	var offset: float = CARD_PLACEMENT_OFFSET * (card_drop.card_nodes.size() - 1)

	var new_shape = RectangleShape2D.new()
	new_shape.size = Vector2(
		card_drop.initial_collision_shape_shape.size.x,
		card_drop.initial_collision_shape_shape.size.y + offset,
	)

	card_drop.collision_shape.shape = new_shape
	card_drop.collision_shape.position.y = card_drop.initial_collision_shape_position.y + offset / 2


func _on_weapon_card_drop_node_dropped(droppable_area: DroppableArea, node: Node2D) -> void:
	if !is_players_turn():
		return

	if node is CardNode:
		var card_node = node as CardNode

		Debug.print_info("Trying [%s] to drop %s on %s" % [self, card_node, droppable_area])
		if _equip_weapon(droppable_area, card_node):
			Store.player_move += 1
			return

		if _attack_monster(droppable_area, card_node):
			Store.player_move += 1
			return

		card_node.put_back()


func _on_weapon_card_drop_card_nodes_changed(card_drop: DroppableArea) -> void:
	_update_collision_shape(card_drop)
