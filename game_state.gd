extends Node

var game_state: Dictionary = init_default_game_state();

func init_default_game_state() -> Dictionary:
	var game_state: Dictionary = {
		"unlocked_nights": 1, 
	};

	return game_state;
