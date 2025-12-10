class_name CardManager
extends Node

@export var deck: Deck
@export var room: Room
@export var card_holder: Node2D
@export var deck_marker: Marker2D
@export var deck_draw_player: AudioStreamPlayer
@export var card_place_player: AudioStreamPlayer

signal card_dealt

var card_scene: PackedScene = preload("res://scenes/card/card.tscn")


func _ready() -> void:
	if deck_draw_player == null:
		push_error("Deck Draw Player is not assigned to CardManager!")
	if card_place_player == null:
		push_error("Card Place Player is not assigned to CardManager!")


func _on_debug_gui_deal_card() -> void:
	await deal_card()


## Deals a card from the deck to the room. Returns true if successful, false if the room is full.
func deal_card() -> bool:
	Debug.print_info("Dealing a card")

	if not room.can_add_card():
		Debug.print_info("Room is full, cannot deal more cards")
		return false

	var card = deck.draw_card()
	var card_node = card_scene.instantiate() as CardNode
	card_node.card = card

	var add_card_result = room.add_card(card)
	if not add_card_result.success:
		Debug.print_info("Failed to add card to room")
		return false

	card_node.global_position = deck_marker.global_position
	card_holder.add_child(card_node)
	
	# Connect bring-to-front signal
	card_node.bring_to_front_requested.connect(_on_card_bring_to_front)

	# Play draw sound
	deck_draw_player.pitch_scale = randf_range(0.9, 1.1)
	deck_draw_player.play()
	await deck_draw_player.finished

	# Tween from deck to room
	var target_position: Vector2 = add_card_result.card_position
	var mid_point: Vector2 = target_position + Vector2(0, -5)

	var tween = create_tween()

	tween.tween_property(card_node, "global_position", mid_point, 0.2).set_trans(Tween.TRANS_QUART)
	tween.tween_property(card_node, "global_position", target_position, 0.2).set_trans(Tween.TRANS_QUART)

	await tween.finished

	# Play place sound
	card_place_player.pitch_scale = randf_range(0.9, 1.1)
	card_place_player.play()
	await card_place_player.finished

	emit_signal("card_dealt")

	return true


func _on_debug_gui_reset() -> void:
	pass # Replace with function body.

func _on_card_bring_to_front(card_node: CardNode) -> void:
	# Move card to end of children list (top of visual stack)
	var child_count = card_holder.get_child_count()
	var current_index = card_node.get_index()
	if current_index != child_count - 1:
		card_holder.move_child(card_node, child_count - 1)
