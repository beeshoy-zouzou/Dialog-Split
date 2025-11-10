class_name CreditsMenu
extends Control




signal exit_credits_menu



func _ready():
	set_process(false)
	




func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("exit_credits_menu")



func _on_Exit_Button_pressed():
	emit_signal("exit_credits_menu")
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	set_process(false)



