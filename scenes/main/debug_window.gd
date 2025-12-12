extends Window

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var keyEvent = event as InputEventKey

		if keyEvent.keycode == KEY_F1 and keyEvent.pressed and not keyEvent.echo:
			if visible:
				hide()
			else:
				show()
