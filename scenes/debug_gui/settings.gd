extends Node

@export var info_logs_indicator: ColorRect
@export var info_logs_stack_indicator: ColorRect

func _ready() -> void:
	_update()

func _update():
	info_logs_indicator.color = Color(0, 1, 0) if Settings.info_logs_enabled else Color(1, 0, 0)

func _on_toggle_info_logs_pressed() -> void:
	Settings.info_logs_enabled = not Settings.info_logs_enabled
	_update()

func _on_toggle_info_logs_stack_pressed() -> void:
	Settings.info_logs_stack_enabled = not Settings.info_logs_stack_enabled
	_update()
