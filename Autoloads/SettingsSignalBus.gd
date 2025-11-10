extends Node

signal on_subtitles_toggled(toggled) #bool

signal on_window_mode_selected(index) #int

signal on_resolution_selected(index) #int

signal on_master_sound_set(value) #float
signal on_music_sound_set(value) #float
signal on_sfx_sound_set(value) #float

signal set_settings_dictionary(settings_dictionary) #dictionary



signal load_settings_data(settings_dictionary) #dictionary


func emit_load_settings_data(settings_dictionary: Dictionary):
	emit_signal("load_settings_data", settings_dictionary)

func emit_set_settings_dictionary(settings_dictionary: Dictionary):
	emit_signal("set_settings_dictionary", settings_dictionary)

func emit_on_subtitles_toggled(toggled: bool):
	emit_signal("on_subtitles_toggled",toggled)

func emit_on_window_mode_selected(index : int):
	emit_signal("on_window_mode_selected", index)

func emit_on_resolution_selected(index : int):
	emit_signal("on_resolution_selected", index)

func emit_on_master_sound_set(value: int):
	emit_signal("on_master_sound_set", value)

func emit_on_music_sound_set(value: int):
	emit_signal("on_music_sound_set", value)

func emit_on_sfx_sound_set(value: int):
	emit_signal("on_sfx_sound_set", value)
