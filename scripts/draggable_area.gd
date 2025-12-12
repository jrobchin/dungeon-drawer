class_name DraggableArea
extends Area2D

@export var root_node: Node2D
@export var draggable: bool = true

signal drag_start
signal drag_end
signal dropped(area: DroppableArea)

@onready var _pick_up_collision_shape: CollisionShape2D = get_node("PickUp")
@onready var _drop_collision_shape: CollisionShape2D = get_node("Drop")


func _ready() -> void:
	if not root_node:
		root_node = get_parent() as Node2D

	assert(root_node, "DraggableArea must be the child of the node to drag.")
	assert(_pick_up_collision_shape, "DroppableArea must have a PickUp CollisionShape2D")
	assert(_drop_collision_shape, "DroppableArea must have a Drop CollisionShape2D")


func _on_input_event(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_button_event := event as InputEventMouseButton

		if mouse_button_event.button_index == MOUSE_BUTTON_LEFT:
			if not draggable:
				return

			if mouse_button_event.pressed and not Store.is_dragging and Store.dragging_node == null:
				# Check if this is the topmost draggable area at this position
				if _is_topmost_at_mouse():
					start_drag()
					_update_position()

					viewport.set_input_as_handled()


func _process(_delta: float) -> void:
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		end_drag()
		_check_drop()

	if Store.is_dragging and Store.dragging_node == self:
		root_node.global_position = get_global_mouse_position()

		# Prevent other nodes from processing this input
		get_viewport().set_input_as_handled()


func _update_position() -> void:
	root_node.global_position = get_global_mouse_position()


func start_drag() -> void:
	_pick_up_collision_shape.disabled = true
	_drop_collision_shape.disabled = false
	Store.dragging_node = self
	Store.is_dragging = true

	drag_start.emit()

	set_process(true)


func end_drag() -> void:
	_pick_up_collision_shape.disabled = false
	_drop_collision_shape.disabled = true
	Store.is_dragging = false
	Store.dragging_node = null

	drag_end.emit()

	set_process(false)


func _check_drop() -> void:
	Debug.print_info("Checking %s drop" % self.get_parent())
	var areas = get_overlapping_areas()
	for area in areas:
		if area is DroppableArea:
			area.drop(get_parent())
			return

	Debug.print_info("%s not dropped on an area" % self.get_parent())
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
