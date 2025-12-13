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

signal last_skipped_changed(value: int)

## Tracks the turn that the player last skipped on.
var last_skipped: int = -2:
	set(value):
		last_skipped = value
		last_skipped_changed.emit(value)

## Tracks if the player has used a health potion this turn.
var used_health_potion: bool = false

## Stores if the player is currently dragging.
var is_dragging: bool = false

## Stores that currently dragged node. Null if the player is not dragging anything.
var dragging_node: Node2D = null


func initialize() -> void:
	player_turn = 0
	player_move = 0
	player_health = Settings.max_player_health

	last_skipped = -2

	used_health_potion = false

	is_dragging = false
	dragging_node = null
