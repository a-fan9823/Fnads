extends Node

func _ready() -> void:
	load_game()

func save_game() -> void:
	var save_data : Dictionary = {
		"settings": global_settings.settings,
		"game_state": game_state.game_state
	}
	
	var save_str : String = JSON.stringify(save_data, "\t");
	var save_file := FileAccess.open("user://save_data.json", FileAccess.WRITE);
	save_file.store_string(save_str);
	save_file.close();
	print("Game Saved! :yay:")


## Tries to load the last saved gamestate[br]
## [br]
## Returns: success
func load_game() -> bool:
	var load_file:= FileAccess.open("user://save_data.json", FileAccess.READ);
	
	if FileAccess.get_open_error() != Error.OK: return false;
	
	var load_str: String = load_file.get_as_text();
	load_file.close();
	var load_data := JSON.parse_string(load_str) as Dictionary;
	
	load_settings(load_data["settings"]);
	load_game_state(load_data["game_state"]);
	return true;


func load_settings(settings_data: Dictionary) -> void:
	for key in global_settings.settings.keys():
		var data: Variant = settings_data.get(key);
		if data == null: continue;
		
		if typeof(data) == TYPE_ARRAY:
			for i in global_settings.settings[key].size():
				global_settings.settings[key][i] = data[i];
		else: global_settings.settings[key] = data;
	
	DisplayServer.window_set_mode(global_settings.settings["window_mode"] as int)
	for i in AudioServer.bus_count:
		global_settings.change_volume([i,global_settings.settings["volume"][i] as float]);

func load_game_state(game_state_data: Dictionary) -> void:
	for key in game_state.game_state.keys():
		var data: Variant = game_state_data.get(key);
		if data == null: continue;
		
		if typeof(data) == TYPE_ARRAY:
			for i in game_state.game_state[key].size():
				game_state.game_state[key][i] = data[i];
		else: game_state.game_state[key] = data;
