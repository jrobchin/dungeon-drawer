extends Control

signal deal_card
signal shuffle_deck

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var keyEvent = event as InputEventKey

		if keyEvent.keycode == KEY_F1 and keyEvent.pressed and not keyEvent.echo:
			visible = not visible


func _on_deal_card_button_up() -> void:
	emit_signal("deal_card")


func _on_shuffle_deck_button_up() -> void:
	emit_signal("shuffle_deck")


func _on_toggle_info_logs_stack_pressed() -> void:
	pass # Replace with function body.
