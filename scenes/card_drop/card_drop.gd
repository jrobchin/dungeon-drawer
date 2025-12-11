class_name CardDrop
extends DroppableArea

var hover: bool = false
var card_nodes: Array[CardNode] = []


func can_drop(node: Node) -> bool:
	# TODO: MOVE TO NON COMMON SCRIPT
	if node is CardNode:
		var card_node = node as CardNode
		if card_node.card.suit == Cards.Suit.DIAMONDS:
			if card_nodes.is_empty():
				return true

	return false


func _on_area_exited(_area: Area2D) -> void:
	hover = false

	$PlaceholderHighlight.visible = false


func _on_area_entered(_area: Area2D) -> void:
	hover = true

	$PlaceholderHighlight.visible = true
