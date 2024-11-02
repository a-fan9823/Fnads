extends Control

@export_dir var defaultpath
var pic_inx := 0
var loadable_pics: Array
@onready var texture_rect:= $TextureRect
signal finished_peetza_cache
signal peetza_cache_file_loaded

func _ready() -> void:
	var loadable_pic_paths: Array
	# Ensure the directory exists, populate loadable_pics with file paths only
	if !DirAccess.dir_exists_absolute(defaultpath):
		printerr("Cannot find path for photos app: ", defaultpath)
		return

	for file in DirAccess.get_files_at(defaultpath):
		if file.ends_with(".png") or file.ends_with(".jpg"):
			loadable_pic_paths.append(str(defaultpath, "/", file))

	if !loadable_pic_paths.is_empty():
		for each in loadable_pic_paths:
			loadable_pics.append(load(each))
			emit_signal("peetza_cache_file_loaded")
			await get_tree().process_frame
	emit_signal("finished_peetza_cache")
	load_img()

func _on_back_pressed() -> void:
	if pic_inx > 0:
		pic_inx -= 1
		load_img()

func _on_next_pressed() -> void:
	if pic_inx < loadable_pics.size() - 1:
		pic_inx += 1
		load_img()

func load_img() -> void:
	if loadable_pics.size() >= 1:
		texture_rect.texture = loadable_pics[pic_inx]
