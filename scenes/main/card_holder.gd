class_name CardHolder
extends Node2D

func initialize() -> void:
	for child in get_children():
		if child is CardNode:
			child.queue_free()
