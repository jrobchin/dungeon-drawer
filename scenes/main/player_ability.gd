class_name PlayerAbility
extends Node

var player_turn: PlayerTurn


func _ready() -> void:
	var parent = get_parent()
	assert(parent is PlayerTurn, "%s must be a child of %s" % [self, "PlayerTurn"])
	player_turn = parent as PlayerTurn


func is_players_turn() -> bool:
	if player_turn.is_active:
		return true
	return false
