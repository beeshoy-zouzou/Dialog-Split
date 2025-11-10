class_name MainMenu
extends Control

onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button as Button
onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
onready var options_menu = $Options_Menu as OptionsMenu
onready var margin_container = $MarginContainer as MarginContainer
onready var credits_button = $MarginContainer/HBoxContainer/VBoxContainer/Credits_Button as Button
onready var credits_menu = $Credits_Menu as CreditsMenu

export var start_level = preload("res://Scenes/Game/Main.tscn") 


func _ready():
	pass






func _on_Exit_Button_pressed():
	get_tree().quit()

func _on_Options_Button_pressed():
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func _on_Start_Button_pressed():
	get_tree().change_scene_to(start_level)




func _on_Options_Menu_exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false
	

func handle_connecting_signals():
	pass


func _on_Credits_Button_pressed():
	margin_container.visible = false
	credits_menu.set_process(true)
	credits_menu.visible = true


func _on_Credits_Menu_exit_credits_menu():
	margin_container.visible = true
	credits_menu.visible = false
