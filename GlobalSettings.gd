extends Node
#array[0] volume
#array[1] display
var settings_array: =[[1,1,1],[]]
signal volume_change(Array)

func _ready() -> void:
	connect("volume_change",Callable(self,"_on_volume_change"))

func _linear_to_db(value: float) -> float:
	if value < 1:
		return -80
	else:
		return -45 + (value / 100) * 40


func _on_volume_change(data:Array) -> void:
	if data[0] < settings_array[0].size() && data[0] < AudioServer.bus_count:
		settings_array[0][data[0]]
		var vol_db = _linear_to_db(data[1])
		AudioServer.set_bus_volume_db(data[0],vol_db)
		print("setting volume {",AudioServer.get_bus_name(data[0]),"}[",data[0],"] to ",vol_db,"  DB")
	else:
		printerr("OUT OF BOUNDS, attempt to change volume on channel [",data[0],"]")
