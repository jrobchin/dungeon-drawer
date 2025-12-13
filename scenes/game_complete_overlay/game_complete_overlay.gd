extends Control

signal play_again


func set_game_complete(win: bool, points: int):
	if win:
		%Message.text = Settings.message_win
	else:
		%Message.text = Settings.message_lose

	%Points.text = "Points: %s" % points


func _on_play_again_button_up() -> void:
	%GameStateMachine.set_state(GameState.INITIALIZING)
	visible = false
	play_again.emit()


func _on_player_turn_game_complete(win: bool, points: int) -> void:
	set_game_complete(win, points)
	visible = true
