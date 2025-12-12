extends Sprite2D

func _on_card_drop_area_exited(_area: Area2D) -> void:
	visible = false


func _on_card_drop_area_entered(_area: Area2D) -> void:
	visible = true
