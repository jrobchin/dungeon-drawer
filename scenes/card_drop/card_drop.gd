class_name CardDrop
extends DroppableArea

var card_nodes: Array[CardNode] = []

signal card_nodes_changed(card_drop: DroppableArea)


func initialize() -> void:
	remove_cards()


func add_card(card_node: CardNode) -> void:
	card_nodes.append(card_node)
	card_nodes_changed.emit(self)


func remove_cards():
	card_nodes.clear()
	card_nodes_changed.emit(self)
