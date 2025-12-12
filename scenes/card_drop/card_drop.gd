class_name CardDrop
extends DroppableArea

var card_nodes: Array[CardNode] = []


func initialize() -> void:
	remove_cards()


func add_card(card_node: CardNode) -> void:
	card_nodes.append(card_node)


func remove_cards():
	card_nodes.clear()
