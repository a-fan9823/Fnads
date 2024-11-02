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
