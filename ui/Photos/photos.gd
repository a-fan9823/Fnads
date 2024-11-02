extends Control


@onready var texture_rect:= $TextureRect

var loadable_pic_paths: Array

func _ready() -> void:
#region REMOVED, image caching
	#if !loadable_pic_paths.is_empty():
		#for each in loadable_pic_paths:
			#loadable_pics.append(load(each))
			#emit_signal("peetza_cache_file_loaded")
			#await get_tree().process_frame
	#emit_signal("finished_peetza_cache")
#endregion
	prepare_photo_list("res://assets/peetza_pics") #get list of all photo paths for loading
	load_img()

var pic_inx := 0
func _on_back_pressed() -> void:
	if pic_inx > 0:
		pic_inx -= 1
		load_img()

func _on_next_pressed() -> void:
	if pic_inx < loadable_pic_paths.size() - 1:
		pic_inx += 1
		load_img()

func load_img() -> void:
	if loadable_pic_paths.size() >= 1:
		texture_rect.texture = load(loadable_pic_paths[pic_inx])
		$Label.text = loadable_pic_paths[pic_inx].substr(loadable_pic_paths[pic_inx].rfind("/") + 1,loadable_pic_paths[pic_inx].length() - loadable_pic_paths[pic_inx].rfind("/"))
	##good orb is this super un-readable ^, sorry it just grabs the file name from the full file path, 'simple' string manipulation...  --walmart

func prepare_photo_list(defaultpath:String):
	# Ensure the directory exists
	if DirAccess.open(defaultpath) == null:
		printerr("Cannot find path for photos app: ", defaultpath)
		return
	if DirAccess.get_files_at(defaultpath).size() >= 1:
		for file in DirAccess.get_files_at(defaultpath): #gets all files in photos path 
			if file.ends_with(".png") or file.ends_with(".jpg"): #checks if its a valid image file
				loadable_pic_paths.append(str(defaultpath, "/", file)) #appends it to the list of image paths
	else:
		printerr("Cannot find photos in: ", defaultpath)


signal request_window_close
func on_close_button_pressed(): emit_signal("request_window_close")
