extends Label

func _ready() -> void:
	Store.player_health_changed.connect(_on_store_player_health_changed)


func _on_store_player_health_changed(value: int) -> void:
	text = "%d/%d" % [value, Settings.max_player_health]
