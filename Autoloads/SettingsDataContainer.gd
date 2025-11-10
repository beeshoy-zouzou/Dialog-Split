extends Node

onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://Scenes/Resources/Settings/DefaultSettings.tres")
onready var DEFAULT_KEYBINDS : PlayerKeybindResource = preload("res://Scenes/Resources/Settings/DefaultKeybinds.tres")

var window_mode_index : int = 0
var resolution_index: int = 0
var master_volume: float = 0.0
var music_volume: float = 0.0
var sfx_volume: float = 0.0
var subtitles_set: bool = false

var loaded_data : Dictionary = {}

func _ready():
	handle_signals()
	create_storage_dictionary()


func create_storage_dictionary() -> Dictionary:
	var settings_container_dictionary : Dictionary = {
		"window_mode_index" : window_mode_index,
		"resolution_index" : resolution_index,
		"master_volume" : master_volume,
		"music_volume" : music_volume,
		"sfx_volume" : sfx_volume,
		"subtitles_set" : subtitles_set,
		"keybinds" : create_keybinds_dictionary()
		
	}
	
	return settings_container_dictionary


func create_keybinds_dictionary() -> Dictionary:
	var keybinds_container_dictionary ={
		DEFAULT_KEYBINDS.MOVE_LEFT : DEFAULT_KEYBINDS.move_left_key,
		DEFAULT_KEYBINDS.MOVE_RIGHT : DEFAULT_KEYBINDS.move_right_key,
		DEFAULT_KEYBINDS.JUMP : DEFAULT_KEYBINDS.jump_key
	}
	
	return keybinds_container_dictionary

func get_window_mode_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_WINDOW_MODE_INDEX
	return window_mode_index

func get_resolution_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_RESOLUTION_INDEX
	return resolution_index

func get_master_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MASTER_VOLUME
	return master_volume

func get_music_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MUSIC_VOLUME
	return music_volume

func get_sfx_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SFX_VOLUME
	return sfx_volume

func get_subtitles_set() -> bool:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SUBTITLES_SET
	return subtitles_set

func get_keybind(action: String):
	if loaded_data.has("keybinds"):
		match action:
			DEFAULT_KEYBINDS.MOVE_LEFT:
				return DEFAULT_KEYBINDS.default_move_left_key
			DEFAULT_KEYBINDS.MOVE_RIGHT:
				return DEFAULT_KEYBINDS.default_move_right_key
			DEFAULT_KEYBINDS.JUMP:
				return DEFAULT_KEYBINDS.default_jump_key
	else:
		match action:
			DEFAULT_KEYBINDS.MOVE_LEFT:
				return DEFAULT_KEYBINDS.move_left_key
			DEFAULT_KEYBINDS.MOVE_RIGHT:
				return DEFAULT_KEYBINDS.move_right_key
			DEFAULT_KEYBINDS.JUMP:
				return DEFAULT_KEYBINDS.jump_key

func _on_window_mode_selected(index: int):
	window_mode_index = index


func _on_resolution_selected(index: int):
	resolution_index = index


func  _on_subtitles_toggled(toggled: bool):
	subtitles_set = toggled


func _on_master_sound_set(value: float):
	master_volume = value


func _on_music_sound_set(value: float):
	music_volume = value


func _on_sfx_sound_set(value: float):
	sfx_volume = value

func set_keybind(action: String, event):
	match action:
		DEFAULT_KEYBINDS.MOVE_LEFT:
			DEFAULT_KEYBINDS.move_left_key = event
		DEFAULT_KEYBINDS.MOVE_RIGHT:
			DEFAULT_KEYBINDS.move_right_key = event
		DEFAULT_KEYBINDS.JUMP:
			DEFAULT_KEYBINDS.jump_key = event
		


func _on_keybinds_loaded(data: Dictionary):
	var loaded_move_left = InputEventKey.new()
	var loaded_move_right = InputEventKey.new()
	var loaded_jump = InputEventKey.new()
	
	loaded_move_left.set_physical_keycode(int(data.move_left))
	loaded_move_right.set_physical_keycode(int(data.move_right))
	loaded_jump.set_physical_keycode(int(data.jump))
	
	DEFAULT_KEYBINDS.move_left_key = loaded_move_left
	DEFAULT_KEYBINDS.move_right_key = loaded_move_right
	DEFAULT_KEYBINDS.jump_key = loaded_jump
	


func _on_load_settings_data(data: Dictionary):
	loaded_data = data
	_on_window_mode_selected(loaded_data.window_mode_index)
	_on_resolution_selected(loaded_data.resolution_index)
	_on_subtitles_toggled(loaded_data.subtitles_set)
	_on_master_sound_set(loaded_data.master_volume)
	_on_music_sound_set(loaded_data.music_volume)
	_on_sfx_sound_set(loaded_data.sfx_volume)
	_on_keybinds_loaded(loaded_data.keybinds)

func handle_signals():
	SettingsSignalBus.connect("on_window_mode_selected", self, "_on_window_mode_selected")
	SettingsSignalBus.connect("on_resolution_selected", self, "_on_resolution_selected")
	SettingsSignalBus.connect("on_subtitles_toggled", self, "_on_subtitles_toggled")
	SettingsSignalBus.connect("on_master_sound_set", self, "_on_master_sound_set")
	SettingsSignalBus.connect("on_music_sound_set", self, "_on_music_sound_set")
	SettingsSignalBus.connect("on_sfx_sound_set", self, "_on_sfx_sound_set")
	SettingsSignalBus.connect("load_settings_data", self, "_on_load_settings_data")
