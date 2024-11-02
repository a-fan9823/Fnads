extends CanvasLayer

var screens: Array[Control] = []

func _ready():
	var children = get_children()
	for screen in children:
		if screen is Control:
			screens.push_back(screen)
			screen.connect("request_window_close",Callable(self,"hide_ui"))
	hide_ui()

func hide_ui():
	for screen in screens:
		screen.hide()

func show_screen(screen_name: String):
	hide_ui()
	for screen in screens:
		if screen.name == screen_name:
			screen.show()
			return

func toggle_settings():
	for screen in screens:
		if screen.name == 'Settings':
			if screen.visible:
				screen.hide()
			else:
				screen.show()
			return
