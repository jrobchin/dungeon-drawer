@tool
class_name CardNode
extends Node2D

var card: Cards.Card

signal bring_to_front_requested(card_node: CardNode)


func _ready() -> void:
	if card != null:
		$CardSprite.update_sprite(card.rank, card.suit)


func _on_draggable_area_on_drag_end() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)


func _on_draggable_area_on_drag_start() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 1.05, 0.1)

	# Emit signal for card tree to handle z-index management
	emit_signal("bring_to_front_requested", self)
