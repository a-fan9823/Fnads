extends Control

@export_dir var defaultpath
var pic_inx := 0
@onready var loadable_pics := PackedStringArray()

func _ready() -> void:
	# Ensure the directory exists, populate loadable_pics with file paths only
	if !DirAccess.dir_exists_absolute(defaultpath):
		printerr("Cannot find path for photos app: ", defaultpath)
		return

	for file in DirAccess.get_files_at(defaultpath):
		if file.ends_with(".png") or file.ends_with(".jpg"):
			loadable_pics.append(str(defaultpath, "/", file))

	# Clamp pic_inx to stay within bounds
	pic_inx = clampi(pic_inx, 0, loadable_pics.size() - 1)
	if pic_inx >= 0 and pic_inx < loadable_pics.size():
		load_img()

func _on_button_pressed() -> void:
	if pic_inx > 0:
		pic_inx -= 1
		load_img()

func _on_button_2_pressed() -> void:
	if pic_inx < loadable_pics.size() - 1:
		pic_inx += 1
		load_img()

func load_img() -> void:
	# Only load the image at pic_inx when needed
	if loadable_pics.size() > 0 and pic_inx >= 0 and pic_inx < loadable_pics.size():
		var file_path = loadable_pics[pic_inx]
		
		# Show loading label and hide the texture
		$Label.show()
		$TextureRect.hide()

		# Load the image resource asynchronously
		var image_resource = await load(ProjectSettings.globalize_path(file_path))

		# Check if the image is valid and then set it
		if image_resource != null:
			$TextureRect.texture = image_resource
			$TextureRect.show()  # Show the image
		else:
			printerr("Failed to load image: ", file_path)
			$TextureRect.hide()  # Hide texture if failed to load
		
		# Hide the loading label after processing
		$Label.hide()
	else:
		printerr("No images available to load.")
