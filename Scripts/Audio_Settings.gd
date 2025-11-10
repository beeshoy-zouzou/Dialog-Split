extends Control

onready var audio_name_label = $HBoxContainer/Audio_Name_Label as Label
onready var audio_num_label = $HBoxContainer/Audio_Num_Label as Label
onready var h_slider = $HBoxContainer/HSlider as HSlider



export(int, "Master", "Music", "Sfx") var selected_bus := 0

var bus_name = AudioServer.get_bus_name(selected_bus)


func _ready():
	get_bus_name()
#	load_data()
	set_audio_name_label_text()
	set_slider_value()
	


func load_data():
	
	match bus_name:
		"Master":
			_on_HSlider_value_changed(SettingsDataContainer.get_master_volume())
		"Music":
			_on_HSlider_value_changed(SettingsDataContainer.get_music_volume())
		"Sfx":
			_on_HSlider_value_changed(SettingsDataContainer.get_sfx_volume())

func set_audio_name_label_text():
	
	audio_name_label.text = str(AudioServer.get_bus_name(selected_bus)) + " Volume"


func set_audio_num_label_text():
	audio_num_label.text = str(h_slider.value * 100)


func get_bus_name():
	var name_bus = AudioServer.get_bus_name(selected_bus)
	selected_bus = AudioServer.get_bus_index(name_bus)


func set_slider_value():
	h_slider.value = db2linear(AudioServer.get_bus_volume_db(selected_bus))
	set_audio_num_label_text()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(selected_bus, linear2db(value))
	set_audio_num_label_text()
	
	match selected_bus:
		0:
			SettingsSignalBus.emit_on_master_sound_set(value)
		1:
			SettingsSignalBus.emit_on_music_sound_set(value)
		2:
			SettingsSignalBus.emit_on_sfx_sound_set(value)
	
