extends Control

@export_dir var defaultpath
var pic_inx := 0
var loadable_pics: Array
@onready var label:= $Label
@onready var texture_rect:= $TextureRect

func _ready() -> void:
	# Ensure the directory exists, populate loadable_pics with file paths only
	if !DirAccess.dir_exists_absolute(defaultpath):
		printerr("Cannot find path for photos app: ", defaultpath)
		return

	for file in DirAccess.get_files_at(defaultpath):
		if file.ends_with(".png") or file.ends_with(".jpg"):
			loadable_pics.append(str(defaultpath, "/", file))

func _on_back_pressed() -> void:
	if pic_inx > 0:
		pic_inx -= 1
		load_img()

func _on_next_pressed() -> void:
	if pic_inx < loadable_pics.size() - 1:
		pic_inx += 1
		load_img()

func load_img() -> void:
	
	##We could also think about loading them only once instead of every time we display them. For that you can change the String array
	##to a Texture2D array.  --hede wan
	
	var file_path = loadable_pics[pic_inx]
	
	# Show loading label and hide the texture
	label.show()
	texture_rect.hide()

	var image_resource = load(file_path)

	texture_rect.texture = image_resource
	texture_rect.show()  # Show the image
	
	# Hide the loading label after processing
	label.hide()
