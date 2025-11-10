class_name Settings
extends Control

onready var tab_container = $TabContainer as TabContainer
onready var notice = $CenterContainer/Label

signal Exit_Options_Menu

func _ready():
	tab_container.visible = false
#	notice.visible = true
#	notice.bbcode_enabled = true
#	notice.text = "[center][b][color=orange]⚠ Notice:[/color][/b]\n\nThe options menu is disabled in this prototype.\n\nIt will be available in a future version of the game.[/center]"

func _process(delta):
	options_menu_input()


func _on_TabContainer_tab_changed(tab):
	tab_container.set_current_tab(tab)

func options_menu_input():
	if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		if tab_container.current_tab >= tab_container.get_tab_count() - 1:
			_on_TabContainer_tab_changed(0)
			return
		var next_tab = tab_container.current_tab + 1
		_on_TabContainer_tab_changed(next_tab)
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		if tab_container.current_tab == 0:
			_on_TabContainer_tab_changed(tab_container.get_tab_count() - 1)
		var previous_tab = tab_container.current_tab - 1
		_on_TabContainer_tab_changed(previous_tab)
	
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("Exit_Options_Menu")
