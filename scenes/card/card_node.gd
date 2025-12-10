@tool
class_name CardNode extends Node2D

var card: Cards.Card

signal bring_to_front_requested(card_node)

func _ready() -> void:
	if card != null:
		$CardSprite.update_sprite(card.rank, card.suit)

func _on_bring_to_front() -> void:
	# Emit signal for cardholder to handle z-index management
	emit_signal("bring_to_front_requested", self)
