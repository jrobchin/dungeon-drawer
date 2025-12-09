extends Node

@export var deck: Deck
@export var room: Room
@export var deck_marker: Marker2D
@export var room_card_marker_0: Marker2D
@export var room_card_marker_1: Marker2D
@export var room_card_marker_2: Marker2D
@export var room_card_marker_3: Marker2D

var card_scene: PackedScene = preload("res://scenes/card/card.tscn")


func _on_debug_gui_deal_card() -> void:
	deal_card()


func _get_room_card_markers() -> Array:
	return [room_card_marker_0, room_card_marker_1, room_card_marker_2, room_card_marker_3]


## Deals a card from the deck to the room. Returns true if successful, false if the room is full.
func deal_card() -> bool:
	Debug.print_info("Dealing a card")

	if not room.can_add_card():
		Debug.print_info("Room is full, cannot deal more cards")
		return false

	var card = deck.draw_card()
	var card_node = card_scene.instantiate() as CardNode
	card_node.card = card

	var room_card_index = room.add_card(card_node)

	card_node.global_position = deck_marker.global_position

	# Tween from deck to room
	var target_position: Vector2 = _get_room_card_markers()[room_card_index].global_position
	var mid_point: Vector2 = target_position + Vector2(0, -5)

	var tween = create_tween()
	tween.tween_property(card_node, "global_position", mid_point, 0.3).set_trans(Tween.TRANS_QUART)
	tween.tween_property(card_node, "global_position", target_position, 0.2).set_trans(Tween.TRANS_QUART)

	return true


func _on_debug_gui_reset() -> void:
	pass # Replace with function body.
