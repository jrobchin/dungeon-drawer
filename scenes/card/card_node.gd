@tool
class_name CardNode
extends Node2D

## Holds the playing card related data.
var card: Cards.Card

## The current status of the card.
var status: Cards.STATUS
var last_picked_up_position: Vector2
var dragging: bool = false

var draggable: bool = false:
	set(value):
		draggable = value
		$DraggableArea.draggable = value

signal bring_to_front_requested(card_node: CardNode)
signal card_dropped(card_node: CardNode)


func _ready() -> void:
	if card != null:
		$CardSprite.update_sprite(card.rank, card.suit)

	$DraggableArea.draggable = draggable


## Puts the card back to the last place it was picked up.
func put_back() -> void:
	global_position = last_picked_up_position
	dragging = false
	$DraggableArea.end_drag()


func _on_draggable_area_dropped(area: DroppableArea) -> void:
	dragging = false
	if area == null:
		Debug.print_info("Resetting card: %s position" % self)
		global_position = last_picked_up_position
		return


func _on_draggable_area_drag_end() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)

	dragging = false

	card_dropped.emit(self)


func _on_draggable_area_drag_start() -> void:
	last_picked_up_position = global_position
	dragging = true

	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 1.05, 0.1)

	# Emit signal for card tree to handle z-index management
	bring_to_front_requested.emit(self)
