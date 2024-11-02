extends Control

@onready var optionbutton:= $ScrollContainer/VBoxContainer/OptionButton
@onready var spinbox:= $ScrollContainer/VBoxContainer/HSlider4/SpinBox
@onready var fps_slider:= $ScrollContainer/VBoxContainer/HSlider4


func on_slider_changed(value: float, id: int) -> void:
	if id < 3:
		change_volume([id, value])
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

func float_to_db(value: float) -> float:
	if value < 1:
		return -80
	else:
		return -45 + (value / 100) * 40

func change_volume(data:Array) -> void:
	if data[0] < global_settings.settings["volume"].size() && data[0] < AudioServer.bus_count:
		global_settings.settings["volume"][data[0]] = data[1]
		var vol_db = float_to_db(data[1])
		AudioServer.set_bus_volume_db(data[0],vol_db)
		print("setting volume {",AudioServer.get_bus_name(data[0]),"}[",data[0],"] to ",vol_db,"  DB")
		save_manager.save_game()
	else:
		printerr("OUT OF BOUNDS, attempt to change volume on channel [",data[0],"]")

func change_target_fps(value:int):
	if value >= 10:
		Engine.max_fps = value
		global_settings.settings["fps"] = value
		spinbox.value = value
		fps_slider.value = value
		print("setting target fps to [",value,"]")
		save_manager.save_game()
