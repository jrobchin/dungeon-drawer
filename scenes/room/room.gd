class_name Room
extends Node2D

class AddCardResult:
	var success: bool
	var card_position: Vector2


	func _init(_success: bool = false, _card_position: Vector2 = Vector2.ZERO) -> void:
		success = _success
		card_position = _card_position


var card_nodes: Array[CardNode]

@onready var card_positions: Array[Marker2D] = [
	$CardPosition0,
	$CardPosition1,
	$CardPosition2,
	$CardPosition3,
]


func _num_cards() -> int:
	var count: int = 0
	for card_node in card_nodes:
		if card_node != null:
			count += 1
	return count


func _first_empty_index() -> int:
	for i in range(card_nodes.size()):
		if card_nodes[i] == null:
			return i
	return -1


func set_draggable(value: bool):
	for card_node in card_nodes:
		if card_node != null:
			card_node.draggable = value


func initialize() -> void:
	card_nodes = [null, null, null, null]
	Debug.print_info("Room initialized.")


## Checks if a card can be added.
func can_add_card() -> bool:
	var num_cards = _num_cards()
	Debug.print_info("Number of card_nodes in room: %d" % num_cards)
	return num_cards < card_nodes.size()


func is_in_room(card: Cards.Card):
	return card_nodes.find(card) > -1


## Adds a card to the room. Returns the result of adding the card.
func add_card(card_node: CardNode) -> AddCardResult:
	if not can_add_card():
		Debug.print_info("Cannot add card, room is full.")
		return null

	var first_empty_index = _first_empty_index()
	if first_empty_index == -1:
		printerr("Error: No empty index found, but room is not full?")

	Debug.print_info("Adding card to room")

	card_nodes[first_empty_index] = card_node

	Debug.print_info("Cards: " + str(card_nodes))

	return AddCardResult.new(true, card_positions[first_empty_index].global_position)


func remove_card(card_node: CardNode) -> bool:
	var idx = card_nodes.find(card_node)
	if idx < 0:
		return false

	card_nodes[idx] = null

	return true
