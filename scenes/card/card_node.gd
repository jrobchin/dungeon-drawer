@tool
class_name CardNode
extends Node2D

var card: Cards.Card

signal bring_to_front_requested(card_node: CardNode)


func _ready() -> void:
	if card != null:
		$CardSprite.update_sprite(card.rank, card.suit)


func _on_draggable_area_on_drag_end() -> void:
	pass # Replace with function body.


func _on_draggable_area_on_drag_start() -> void:
	# Emit signal for cardholder to handle z-index management
	emit_signal("bring_to_front_requested", self)
