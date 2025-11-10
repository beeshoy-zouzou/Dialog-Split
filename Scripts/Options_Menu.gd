class_name OptionsMenu
extends Control

onready var exit_button = $MarginContainer/VBoxContainer/Exit_Button as Button
onready var settings = $MarginContainer/VBoxContainer/Settings as Settings

signal exit_options_menu


# Called when the node enters the scene tree for the first time.
func _ready():
	settings.connect("Exit_Options_Menu",self,"_on_Exit_Button_pressed")
	set_process(false)






func _on_Exit_Button_pressed():
	emit_signal("exit_options_menu")
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	set_process(false)



