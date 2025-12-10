class_name DraggableArea
extends Area2D

@export var root_node: Node2D
@export var draggable: bool = true

signal on_drag_start
signal on_drag_end

var _drag_start_pos := Vector2.ZERO
var _node_start_pos := Vector2.ZERO

static var _active_dragger: DraggableArea = null


func _ready() -> void:
	if not root_node:
		root_node = get_parent() as Node2D


func _on_input_event(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton

		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if not draggable:
				return

			if mouse_event.pressed and not Store.is_dragging and _active_dragger == null:
				# Check if this is the topmost draggable area at this position
				if _is_topmost_at_mouse():
					_start_drag()

					viewport.set_input_as_handled()

			elif not mouse_event.pressed and Store.is_dragging and _active_dragger == self:
				_end_drag()

				viewport.set_input_as_handled()


func _input(event: InputEvent) -> void:
	if Store.is_dragging and _active_dragger == self and event is InputEventMouseMotion:
		if root_node:
			var current_mouse_pos := get_global_mouse_position()
			var drag_offset := current_mouse_pos - _drag_start_pos
			root_node.global_position = _node_start_pos + drag_offset

			# Prevent other nodes from processing this input
			get_viewport().set_input_as_handled()


func _start_drag() -> void:
	_active_dragger = self
	Store.is_dragging = true
	Store.dragging_node = root_node
	_drag_start_pos = get_global_mouse_position()
	_node_start_pos = root_node.global_position

	emit_signal("on_drag_start")


func _end_drag() -> void:
	Store.is_dragging = false
	Store.dragging_node = null
	_active_dragger = null
	_check_drop()

	emit_signal("on_drag_end")


func _check_drop() -> void:
	var dropped_into_area := false

	var areas = get_overlapping_areas()
	for area in areas:
		if area is CardDrop:
			dropped_into_area = true
			area.handle_drop(root_node)
			break

	if dropped_into_area:
		draggable = false
	else:
		# Return to original position
		if root_node:
			root_node.global_position = _node_start_pos


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
	if Store.is_dragging and _active_dragger == self:
		Store.is_dragging = false
		_active_dragger = null
