extends Control


onready var options_button = $HBoxContainer/OptionButton as OptionButton


const WINDOW_MODE_ARRAY  = [
	"Full-screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Full-screen"
]




func _ready():
	add_window_mode_item()
#	load_data()

func load_data():
	_on_OptionButton_item_selected(SettingsDataContainer.get_window_mode_index())
	options_button.select(SettingsDataContainer.get_window_mode_index())

func add_window_mode_item():
	for window_mode in WINDOW_MODE_ARRAY:
		options_button.add_item(window_mode)


func _on_OptionButton_item_selected(index):
	SettingsSignalBus.emit_on_window_mode_selected(index)
	match index:
		0: #Fullscreen
			OS.set_window_fullscreen(true)
			OS.set_borderless_window(false)
		1: # Window Mode
			OS.set_window_fullscreen(false)
			OS.set_borderless_window(false)
		2: #Borderless Window
			OS.set_window_fullscreen(false)
			OS.set_borderless_window(true)
		3: #Borderless Fullscreen (Not working)
			OS.set_window_fullscreen(true)
			OS.set_borderless_window(true)
