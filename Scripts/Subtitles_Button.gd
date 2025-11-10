extends Control

onready var state_label = $HBoxContainer/State_Label as Label
onready var check_button = $HBoxContainer/CheckButton as CheckButton

func _ready():
	pass
#	load_data()

func load_data():
	if SettingsDataContainer.get_subtitles_set() != true:
		check_button.pressed = false
	else:
		check_button.pressed = true
	set_label_text(SettingsDataContainer.get_subtitles_set())

func set_label_text(button_pressed):
	if button_pressed != true:
		state_label.text = "Off"
	else:
		state_label.text = "On"


func _on_CheckButton_toggled(button_pressed):
	set_label_text(button_pressed)
	SettingsSignalBus.emit_on_subtitles_toggled(button_pressed)
	
	# should be added to a an autoload global dictionary to be passed over the game
