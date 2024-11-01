extends Control

func _ready() -> void:
	global_settings.connect("on_os_window_mode_changed",Callable(self,"_update_dropdown"))

func _on_slider_changed(value: float, id: int) -> void:
	global_settings.emit_signal("volume_change",[id, value])


func _on_option_button_item_selected(index: int) -> void:
	global_settings.emit_signal("window_mode_change",index)

func _update_dropdown(index:int):
	match index:
		0:
			$ScrollContainer/VBoxContainer/OptionButton.selected = index
			prints($ScrollContainer/VBoxContainer/OptionButton.get_item_text(index),index)
		2:
			$ScrollContainer/VBoxContainer/OptionButton.selected = index
			prints($ScrollContainer/VBoxContainer/OptionButton.get_item_text(index),index)
		3:
			$ScrollContainer/VBoxContainer/OptionButton.selected = 1
			prints($ScrollContainer/VBoxContainer/OptionButton.get_item_text(index),index)
