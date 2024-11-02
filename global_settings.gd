extends Node

var settings: Dictionary = {
		"show_splash_screen": true,
		"window_mode": 0,
		"fps": 60,
		"volume": [1,1,1],
		"unlocked_nights": 1,
		"sent_emails": 1
	}

##array layout, [bus,float(max 100)]
func change_volume(data:Array) -> void:
	if data[0] < global_settings.settings["volume"].size() && data[0] < AudioServer.bus_count:
		global_settings.settings["volume"][data[0]] = data[1]
		var vol_db = float_to_db(data[1])
		AudioServer.set_bus_volume_db(data[0],vol_db)
		print("setting volume {",AudioServer.get_bus_name(data[0]),"}[",data[0],"] to ",vol_db,"  DB")
		save_manager.save_game(settings)
	else:
		printerr("OUT OF BOUNDS, attempt to change volume on channel [",data[0],"]")

func float_to_db(value: float) -> float:
	if value < 1:
		return -80
	else:
		return -45 + (value / 100) * 40
