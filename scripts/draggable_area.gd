class_name DraggableArea
extends Area2D

@export var root_node: Node2D
@export var draggable: bool = true

signal drag_start
signal drag_end
signal dropped(area: DroppableArea)

var _drag_start_pos := Vector2.ZERO
var _node_start_pos := Vector2.ZERO


func _ready() -> void:
	if not root_node:
		root_node = get_parent() as Node2D


func _on_input_event(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton

		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if not draggable:
				return

			if mouse_event.pressed and not Store.is_dragging and Store.dragging_node == null:
				# Check if this is the topmost draggable area at this position
				if _is_topmost_at_mouse():
					_start_drag()

					viewport.set_input_as_handled()

			elif not mouse_event.pressed and Store.is_dragging and Store.dragging_node == self:
				_end_drag()

				viewport.set_input_as_handled()


func _input(event: InputEvent) -> void:
	if Store.is_dragging and Store.dragging_node == self and event is InputEventMouseMotion:
		if root_node:
			var current_mouse_pos := get_global_mouse_position()
			var drag_offset := current_mouse_pos - _drag_start_pos
			root_node.global_position = _node_start_pos + drag_offset

			# Prevent other nodes from processing this input
			get_viewport().set_input_as_handled()


func _start_drag() -> void:
	Store.dragging_node = self
	Store.is_dragging = true
	_drag_start_pos = get_global_mouse_position()
	_node_start_pos = root_node.global_position

	drag_start.emit()


func _end_drag() -> void:
	Store.is_dragging = false
	Store.dragging_node = null
	_check_drop()

	drag_end.emit()


func _check_drop() -> void:
	var areas = get_overlapping_areas()
	for area in areas:
		if area is DroppableArea:
			if area.can_drop(get_parent()):
				dropped.emit(area)

	dropped.emit(null)


func _is_topmost_at_mouse() -> bool:
	# Get all draggable areas under the mouse
	var space = get_world_2d().direct_space_state
	var mouse_pos = get_global_mouse_position()
	var params = PhysicsPointQueryParameters2D.new()
	params.position = mouse_pos
	params.collision_mask = collision_mask
	params.collide_with_areas = true

	var results = space.intersect_point(params)

	# Find all DraggableArea nodes in results
	var draggable_areas = []
	for result in results:
		var collider = result.collider
		if collider is DraggableArea:
			draggable_areas.append(collider)

	if draggable_areas.is_empty():
		return false

	# Find the topmost based on tree order (later in tree = on top)
	draggable_areas.sort_custom(
		func(a, b):
			return a.get_parent().get_index() > b.get_parent().get_index()
	)

	# Return true if this is the topmost
	return draggable_areas[0] == self


func _on_mouse_entered() -> void:
	pass


func _on_mouse_exited() -> void:
	if Store.is_dragging and Store.dragging_node == self:
		Store.is_dragging = false
		Store.dragging_node = null
