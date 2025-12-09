@tool
class_name CardNode extends Node2D

var card: Cards.Card

func _ready() -> void:
	if card != null:
		$CardSprite.update_sprite(card.rank, card.suit)
