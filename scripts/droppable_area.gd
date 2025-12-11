class_name DroppableArea
extends Area2D

## Overridden by subclasses. By default, rejects drops.
@warning_ignore("unused_parameter")
func can_drop(node: Node) -> bool:
	return false
