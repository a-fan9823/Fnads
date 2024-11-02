extends Control

@onready var optionbutton:= $ScrollContainer/VBoxContainer/OptionButton
@onready var spinbox:= $ScrollContainer/VBoxContainer/HSlider4/SpinBox
@onready var fps_slider:= $ScrollContainer/VBoxContainer/HSlider4


func on_slider_changed(value: float, id: int) -> void:
	if id < 3:
		global_settings.change_volume([id, value])
	else:
		change_target_fps(value)

func on_window_mode_selected(index: int) -> void:
	var inx = optionbutton.get_item_id(index)
	## borderless window does not seem to work on linux(I am unsure of windows), I have disabled this feature   --Walmart
	if inx >= 0:
		DisplayServer.window_set_mode(inx)
		global_settings.settings["window_mode"] = inx
		optionbutton.selected = index
		prints(optionbutton.get_item_text(index),index)
		save_manager.save_game()
		#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,(window_modes[inx] == DisplayServer.WINDOW_FLAG_BORDERLESS))
	else:
		printerr("ERROR =(  : window_mode_change; index of change[",inx,"]")

func change_target_fps(value:int):
	if value >= 10:
		Engine.max_fps = value
		global_settings.settings["fps"] = value
		spinbox.value = value
		fps_slider.value = value
		print("setting target fps to [",value,"]")
		save_manager.save_game()
