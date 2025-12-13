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

	is_dragging = false
	dragging_node = null
