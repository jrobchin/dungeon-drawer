extends Control

@export var state_manager: StateManager

signal reset
signal deal_card
signal shuffle_deck


func _ready() -> void:
	visible = false

# func _process(_delta: float) -> void:
# 	if state_manager != null:
# 		print("Current State: %s" % state_manager.player_turn)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var keyEvent = event as InputEventKey

		if keyEvent.keycode == KEY_F1 and keyEvent.pressed and not keyEvent.echo:
			visible = not visible


func _on_deal_card_button_up() -> void:
	emit_signal("deal_card")


func _on_shuffle_deck_button_up() -> void:
	emit_signal("shuffle_deck")


func _on_reset_button_up() -> void:
	emit_signal("reset")
