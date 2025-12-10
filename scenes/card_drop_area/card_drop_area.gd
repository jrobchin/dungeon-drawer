class_name CardDropArea
extends Area2D

signal card_dropped(card_node: CardNode)


func handle_drop(card_node: Node2D) -> void:
	# Snap card to this area's position
	card_node.global_position = global_position

	emit_signal("card_dropped", { "node": card_node })
