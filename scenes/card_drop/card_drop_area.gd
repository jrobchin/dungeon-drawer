class_name CardDropArea
extends Area2D

signal card_dropped(card_node: CardNode)

var hover: bool = false


func handle_drop(card_node: Node2D) -> void:
	# Snap card to this area's position
	card_node.global_position = global_position

	emit_signal("card_dropped", { "node": card_node })


func _on_area_exited(_area: Area2D) -> void:
	hover = false

	$PlaceholderHighlight.visible = false


func _on_area_entered(_area: Area2D) -> void:
	hover = true

	$PlaceholderHighlight.visible = true
