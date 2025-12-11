class_name StateManager
extends Node

signal player_turn_changed(value: int)

## Turn the player is currently on.
var player_turn: int = 0:
	set(value):
		player_turn = value
		player_turn_changed.emit(value)

signal player_move_changed(value: int)

## Move the player is currently on.
var player_move: int = 0:
	set(value):
		player_move = value
		player_move_changed.emit(value)

signal player_health_changed(value: int)

## Player health.
@onready var player_health: int = Settings.max_player_health:
	set(value):
		player_health = value
		player_health_changed.emit(value)


func initialize() -> void:
	player_turn = 0
	player_move = 0
	player_health = Settings.max_player_health


func _on_debug_gui_health_changed(value: int) -> void:
	player_health = value
