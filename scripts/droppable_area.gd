class_name DroppableArea
extends Area2D

signal node_dropped(droppable_area: DroppableArea, node: Node2D)


func drop(node: Node2D) -> void:
	node_dropped.emit(self, node)
