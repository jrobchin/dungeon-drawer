class_name DroppableArea
extends Area2D

signal node_dropped(droppable_area: DroppableArea, node: Node2D)

var collision_shape: CollisionShape2D
var initial_collision_shape_position: Vector2
var initial_collision_shape_shape: RectangleShape2D


func _ready() -> void:
	collision_shape = get_node("./CollisionShape2D") as CollisionShape2D
	assert(collision_shape, "DroppableAreas must have a single child CollisionShape2D called `CollisionShape2D`.")
	initial_collision_shape_position = collision_shape.position

	var col_shape_shape = collision_shape.shape
	assert(col_shape_shape is RectangleShape2D, "DroppableAreas' CollisionShape2D must have a RectangleShape2D shape.")
	initial_collision_shape_shape = col_shape_shape as RectangleShape2D


func drop(node: Node2D) -> void:
	node_dropped.emit(self, node)
