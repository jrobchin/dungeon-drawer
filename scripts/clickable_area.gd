class_name ClickableArea
extends Area2D

signal clicked


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		clicked.emit()
