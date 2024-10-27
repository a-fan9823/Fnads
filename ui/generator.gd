extends Control

@onready var game_root = self.get_parent().get_parent() #The root game node, that contains the power and other primary values

func _ready() -> void:
	if game_root is Node2D and game_root.name == "Game":
		var level = game_root.generator_power
		if level < 0:
			level = 0
		if level > 100:
			level = 100
		if level == 0:
			$Label.text = str("OUT OF POWER!")
			$HSplitContainer.split_offset = $HSplitContainer.size.x * (float(0) / 100)
		else:
			$Label.text = str(level,'%')
			$HSplitContainer.split_offset = $HSplitContainer.size.x * (float(level) / 100)
		game_root.connect("on_power_level_changed",Callable(self,"on_power_change"))
	else:
		$Label.text = "36% (ERROR!)"
		$HSplitContainer.split_offset = $HSplitContainer.size.x * 0.36
		printerr("Generator app: Error! game_root not found! cannot load power status")
func on_power_change(level:int) -> void:
	if level < 0:
		level = 0
	if level > 100:
		level = 100
	if level == 0:
		$Label.text = str("OUT OF POWER!")
		$HSplitContainer.split_offset = $HSplitContainer.size.x * (float(0) / 100)
	else:
		$Label.text = str(level,'%')
		$HSplitContainer.split_offset = $HSplitContainer.size.x * (float(level) / 100)
