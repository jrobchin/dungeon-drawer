extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		event = event as InputEventKey
		if event.keycode == KEY_F2:
			take_screenshot()


func take_screenshot(resize: bool = false) -> void:
	var image_path = "screenshots/%d.png" % round(Time.get_unix_time_from_system())

	var width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height = ProjectSettings.get_setting("display/window/size/viewport_height")

	var screenshot = get_viewport().get_texture().get_image()
	if resize:
		screenshot.resize(width, height)

	var err = screenshot.save_png(image_path)
	if err > 0:
		print_debug("Error when saving screenshot: %s" % error_string(err))
