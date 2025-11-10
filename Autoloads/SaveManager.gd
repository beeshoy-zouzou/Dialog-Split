extends Node

const SETTINGS_SAVE_PATH : String = "user://settings.save"


var settings_data_dictionary : Dictionary = {}

func _ready():
	SettingsSignalBus.connect("set_settings_dictionary", self, "_on_settings_save")
	load_settings_data()


func _on_settings_save(data : Dictionary):
	var file = File.new()
	if file.open(SETTINGS_SAVE_PATH, File.WRITE) == OK:
		file.store_line(JSON.print(data))
		file.close()
		print("Settings saved to:", ProjectSettings.globalize_path(SETTINGS_SAVE_PATH))
	else:
		push_error("Failed to save settings")

func load_settings_data():
	var file = File.new()
	if not file.file_exists(SETTINGS_SAVE_PATH):
		return
	
	if file.open(SETTINGS_SAVE_PATH, File.READ) != OK:
		push_error("Settings file not found at" + SETTINGS_SAVE_PATH)
		return
	
	var json_string = file.get_as_text()
	file.close()
	
	var json_result = JSON.parse(json_string)
	
	print("RAW JSON: " + json_string)
	if json_result.error != OK:
		push_error("Parse result code: " + str(json_result.error) + ")" + json_result.error_string)
		return
	
	if typeof(json_result.result) != TYPE_DICTIONARY:
		push_error("Loaded data is not a dictionary. Got type: " + str(typeof(json_result.result)))
		return
	
	var loaded_data = json_result.result
	if typeof(loaded_data) == TYPE_DICTIONARY:
		return (loaded_data)
	push_error("Loaded data is not a Dictionary")
	
	
	SettingsSignalBus.emit_load_settings_data(loaded_data)
	loaded_data = {}
	
	
	

		
