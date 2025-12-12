extends Sprite2D

const RATIO_SHIFT = 0.0


func _ready() -> void:
	Store.player_health_changed.connect(_on_store_player_health_changed)


func _on_store_player_health_changed(value: int) -> void:
	var health_ratio = float(value) / Settings.max_player_health

	if value == 0:
		frame = hframes - 1
	else:
		# Add a shift to keep the health more full
		frame = int((hframes - 1) * (1 - (health_ratio + RATIO_SHIFT)))
