extends Area2D

@export var root: Node2D

var dragging: bool = false
var draggable: bool = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and draggable:
				dragging = true
				Store.is_dragging = true
			else:
				dragging = false
				Store.is_dragging = false
	elif event is InputEventMouseMotion and dragging:
		root.global_position += event.relative


func _on_mouse_entered() -> void:
	if not Store.is_dragging:
		draggable = true


func _on_mouse_exited() -> void:
	draggable = false
