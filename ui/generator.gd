extends Control

@onready var bar:= $ProgressBar
@onready var label:= $Label

func _ready() -> void:
	var game_root = get_tree().get_first_node_in_group("Game")
	var level = game_root.generator_power
	label.text = str(level,'%')
	bar.value = bar.max_value * (float(level) / 100)
	game_root.connect("on_power_level_changed",Callable(self,"on_power_change"))

func on_power_change(level:int) -> void:
	if level == 0:
		label.text = str("OUT OF POWER!")
	else:
		label.text = str(level,'%')
		bar.value = bar.size.x * (float(level) / 100)
