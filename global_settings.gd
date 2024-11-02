extends Node

var settings: Dictionary = init_default_settings();

const default_fps:= 60
signal on_os_window_mode_changed(int)

func init_default_settings() -> Dictionary:
	var default_settings: Dictionary = {
		"show_splash_screen": true,
		"window_mode": 0,
		"fps": default_fps,
		"volume": [],
	}
	for i in AudioServer.bus_count:
		default_settings["volume"].append(1);

	return default_settings;

func _ready() -> void:
	_prev_win_mode = DisplayServer.window_get_mode()

var _prev_win_mode
func _process(delta: float) -> void:
	if _prev_win_mode != DisplayServer.window_get_mode():
		emit_signal("on_os_window_mode_changed",DisplayServer.window_get_mode())
		_prev_win_mode = DisplayServer.window_get_mode()

##array layout, [bus,float(max 100)]
func change_volume(data:Array) -> void:
	if data[0] < global_settings.settings["volume"].size() && data[0] < AudioServer.bus_count:
		global_settings.settings["volume"][data[0]] = data[1]
		var vol_db = float_to_db(data[1])
		AudioServer.set_bus_volume_db(data[0],vol_db)
		print("setting volume {",AudioServer.get_bus_name(data[0]),"}[",data[0],"] to ",vol_db,"  DB")
		save_manager.save_game()
	else:
		printerr("OUT OF BOUNDS, attempt to change volume on channel [",data[0],"]")

func float_to_db(value: float) -> float:
	if value < 1:
		return -80
	else:
		return -45 + (value / 100) * 40
