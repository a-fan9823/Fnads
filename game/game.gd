extends Node2D

@export var generator_power:int = 100
#changes when the generator power level changes
signal on_power_level_changed(new_level: int)
#changes when power hits zero
signal on_power_state_changed(power_state: bool)


##removed, part of peetza loading screen
#@export_dir var defaultpath ## I hate this -- walmart

func _ready():
	break_power(3)

#region Removed peetza loading screen

##region REALLY not proud of doing this calc twice but I couldn't figure out another way
	#var loadable_pic_paths: Array
	## Ensure the directory exists, populate loadable_pics with file paths only
	#if !DirAccess.dir_exists_absolute(defaultpath):
		#printerr("Cannot find path for photos app: ", defaultpath)
		#return
#
	#for file in DirAccess.get_files_at(defaultpath):
		#if file.ends_with(".png") or file.ends_with(".jpg"):
			#loadable_pic_paths.append(str(defaultpath, "/", file))
##endregion
#
	#$"Loading screen/TextureProgressBar".max_value = loadable_pic_paths.size()
	#$"Loading screen".position = get_viewport_rect().position
	#$Camera2D.enabled = false
	#$UI/Photos.connect("finished_peetza_cache",Callable(self,"on_peetza_cached"))
	#$UI/Photos.connect("peetza_cache_file_loaded",Callable(self,"on_file_cached"))
#
#
#
#func on_peetza_cached():
	#$Camera2D.enabled = true
	#$"Loading screen".hide()
	#break_power(3)
#
#func on_file_cached():
	#$"Loading screen/TextureProgressBar".value += 1
#endregion

func break_power(time: int):
	await get_tree().create_timer(time).timeout
	var breakers = get_tree().get_first_node_in_group('Breakers')
	breakers.break_power(6)
	# break_power(60)

func use_generator_power(power: int):
	generator_power -= power
	if generator_power <= 0:
		generator_power = 0
		on_power_state_changed.emit(false)
	on_power_level_changed.emit(generator_power)
