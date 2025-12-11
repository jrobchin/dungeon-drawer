extends Label

func _on_state_manager_player_health_changed(value: int) -> void:
	text = "%d/%d" % [value, Settings.max_player_health]
