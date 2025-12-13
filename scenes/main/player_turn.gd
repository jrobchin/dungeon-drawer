class_name PlayerTurn
extends GameState

enum MOVES {
	EquipWeapon,
}

@export var room: Room
@export var card_tree: CardTree

var is_active: bool = false


func _ready() -> void:
	Store.player_health_changed.connect(_on_player_health_changed)
	Store.player_move_changed.connect(_on_player_move_changed)


func enter(_previous_state_path: String, _data := { }) -> void:
	is_active = true

	Store.player_move = 0

	room.set_draggable(true)

	# TODO: set other areas to be draggable


func exit() -> void:
	is_active = false

	Store.player_turn += 1
	Store.used_health_potion = false

	card_tree.set_draggable(false)


func _on_player_health_changed(value: int):
	if value == 0:
		push_error("Losing not implemented yet!")


func _on_player_move_changed(value: int):
	if value >= Settings.total_player_moves:
		Debug.print_info("Player move ended")
		finished.emit(GameState.DEALING_ROOM)
