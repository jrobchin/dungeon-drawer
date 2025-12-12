class_name PlayerTurn
extends GameState

enum MOVES {
	EquipWeapon,
}

@export var room: Room
@export var card_tree: CardTree

var is_active: bool = false


func enter(_previous_state_path: String, _data := { }) -> void:
	is_active = true

	Store.player_turn += 1

	room.set_draggable(true)

	# TODO: set other areas to be draggable


func exit() -> void:
	is_active = false

	card_tree.set_draggable(false)
