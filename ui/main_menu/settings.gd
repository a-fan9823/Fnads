extends Control


func _on_slider_changed(value: float, id: int) -> void:
	GlobalSettings.emit_signal("volume_change",[id, value])
