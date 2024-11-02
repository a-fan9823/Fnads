extends Control

func _ready() -> void:
	global_settings.emit_signal("target_fps_change",global_settings.default_fps)
	global_settings.connect("on_os_window_mode_changed",Callable(self,"_update_dropdown"))
	global_settings.connect("on_target_fps_changed",Callable(self,"_update_fps_spinbox"))

func _on_slider_changed(value: float, id: int) -> void:
	if id < 3:
		global_settings.emit_signal("volume_change",[id, value])
	else:
		global_settings.emit_signal("target_fps_change",value)

func _update_fps_spinbox(value:int):
	$ScrollContainer/VBoxContainer/HSlider4/SpinBox.value = value
	$ScrollContainer/VBoxContainer/HSlider4.value = value

func _on_option_button_item_selected(index: int) -> void:
	global_settings.emit_signal("window_mode_change",index)

func _update_dropdown(index:int):
	var optionbutton:= $ScrollContainer/VBoxContainer/OptionButton
	match index:
		0:
			optionbutton.selected = index
			prints(optionbutton.get_item_text(index),index)
		2:
			optionbutton.selected = index
			prints(optionbutton.get_item_text(index),index)
		3:
			optionbutton.selected = 1
			prints(optionbutton.get_item_text(index),index)
