extends Node

@export var debug_window: Window


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var keyEvent = event as InputEventKey

		if keyEvent.keycode == KEY_F1 and keyEvent.pressed and not keyEvent.echo:
			if debug_window.visible:
				debug_window.hide()
			else:
				debug_window.show()


func _on_debug_window_close_requested() -> void:
	debug_window.hide()
