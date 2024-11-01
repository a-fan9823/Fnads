extends Node
#array[0] volume
#array[1] display
var settings_array: =[[1,1,1],[0]]
signal volume_change(Array)
signal window_mode_change(int)
const window_modes = [DisplayServer.WINDOW_MODE_WINDOWED,DisplayServer.WINDOW_MODE_FULLSCREEN,DisplayServer.WINDOW_MODE_MAXIMIZED]#,DisplayServer.WINDOW_FLAG_BORDERLESS]
signal on_os_window_mode_changed(int)

func _ready() -> void:
	_prev_win_mode = DisplayServer.window_get_mode()
	connect("volume_change",Callable(self,"_on_volume_change"))
	connect("window_mode_change",Callable(self,"_on_window_mode_change"))

var _prev_win_mode
func _process(delta: float) -> void:
	if _prev_win_mode != DisplayServer.window_get_mode():
		emit_signal("on_os_window_mode_changed",DisplayServer.window_get_mode())
		_prev_win_mode = DisplayServer.window_get_mode()

func _linear_to_db(value: float) -> float:
	if value < 1:
		return -80
	else:
		return -45 + (value / 100) * 40

func _on_window_mode_change(inx:int) -> void:
	## borderless window does not seem to work on linux(I am unsure of windows), I have disabled this feature   --Walmart
	if inx < window_modes.size() && inx >= 0:
		DisplayServer.window_set_mode(window_modes[inx])
		settings_array[1][0] = inx
		#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,(window_modes[inx] == DisplayServer.WINDOW_FLAG_BORDERLESS))
	else:
		printerr("ERROR =(  : window_mode_change; index of change[",inx,"]")

func _on_volume_change(data:Array) -> void:
	if data[0] < settings_array[0].size() && data[0] < AudioServer.bus_count:
		settings_array[0][data[0]]
		var vol_db = _linear_to_db(data[1])
		AudioServer.set_bus_volume_db(data[0],vol_db)
		print("setting volume {",AudioServer.get_bus_name(data[0]),"}[",data[0],"] to ",vol_db,"  DB")
	else:
		printerr("OUT OF BOUNDS, attempt to change volume on channel [",data[0],"]")
