class_name HotkeyButton
extends Control


onready var label = $HBoxContainer/Label as Label
onready var button = $HBoxContainer/Button as Button

export var action_name : String = "move_left"


func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	load_keybinds()

func load_keybinds():
	rebind_action_key(SettingsDataContainer.get_keybind(action_name))

func set_action_name():
	label.text = "Unassigned"
	
	match action_name: 
		"move_left": 
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"jump":
			label.text = "Jump"

func set_text_for_key():
	var action_events = InputMap.get_action_list(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_scancode_string(action_event.scancode)
	
	button.text = "%s" % action_keycode



func _on_Button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key..."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()


func _unhandled_key_input(event):
	rebind_action_key(event)
	button.pressed = false
	

func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	SettingsDataContainer.set_keybind(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
