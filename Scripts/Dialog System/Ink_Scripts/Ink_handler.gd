# warning-ignore-all:return_value_discarded

extends Control

# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")
onready var button = load("res://Scenes/DialogSystemScene/DialogButton.tscn")
onready var tween = $DialogBox/Tween
onready var next_indicator = $"DialogBox/next-indicator"

onready var npc_container = $NPCContainer
onready var player_container = $PlayerContainer
onready var tree_container = $TreeContainer


onready var intro_sound = $IntroSound
onready var choice_sound = $ChoiceSound
onready var tree_sound = $TreeSound
onready var old_man_sound = $OldManSound
onready var dialog_choice = $DialogChoice

onready var dialog_box = $DialogBox


# ############################################################################ #
# Public Nodes
# ############################################################################ #

# Alternatively, it could also be retrieved from the tree.
# onready var _ink_player = $InkPlayer
onready var _ink_player = InkPlayer.new()
onready var _buttons = []
var finished = false
var dialog_final_position = Vector2()
# ############################################################################ #
# Lifecycle
# ############################################################################ #

func _ready():
	
	
	# Adds the player to the tree.
	add_child(_ink_player)

	# Replace the example path with the path to your story.
	# Remove this line if you set 'ink_file' in the inspector.
	_ink_player.ink_file = load("res://Stories/finalstory/Untitled.ink.json")

	# It's recommended to load the story in the background. On platforms that
	# don't support threads, the value of this variable is ignored.
	_ink_player.loads_in_background = true

	_ink_player.connect("loaded", self, "_story_loaded")

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()
	
	dialog_final_position = dialog_box.rect_position 
	dialog_box.rect_position = dialog_final_position + Vector2(0, 200)
	dialog_box.modulate.a = 0 


# ############################################################################ #
# Signal Receivers
# ############################################################################ #
func _process(delta):
	next_indicator.visible = finished

func _story_loaded(successfully: bool):
	if !successfully:
		return

	# _observe_variables()
	# _bind_externals()

	intro_sound.play()
	yield(get_tree().create_timer(3.0), "timeout")
	var final_position = dialog_final_position
#	var start_position = final_position + Vector2(0, 200)\
	var start_position = dialog_box.rect_position
	dialog_box.rect_position = start_position
	tween.interpolate_property(
		dialog_box, "rect_position",
		start_position, final_position,
		1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	tween.interpolate_property(
	dialog_box, "modulate:a",0, 1,1.0, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	yield($IntroSound, "finished")
	_continue_story()


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():
	while _ink_player.can_continue:
		finished = false
		var text = _ink_player.continue_story()
		var tags = _ink_player.current_tags
		var speaker_name = get_current_speaker(tags)
		print("Speaker: ", speaker_name)
		_update_speaker_ui(speaker_name)
		

		
			
		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		#print(text)
		
		var dialog_text = get_node("DialogBox/DialogText")
		dialog_text.bbcode_text = text
		dialog_text.percent_visible = 0
		var duration = 2.0
		if speaker_name == "Narrator":
			duration = 4.0
		tween.interpolate_property(
			dialog_text, "percent_visible", 0, 1, duration, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		tween.start()
		yield(tween, "tween_completed")
		yield(get_tree().create_timer(1.0), "timeout")
	
	if _ink_player.has_choices:
		# 'current_choices' contains a list of the choices, as strings.
		for choice in _ink_player.current_choices:
#			print(choice)
			var btn = button.instance()
			btn.text = choice.text

			btn.connect("pressed", self, "_choose_index", [btn])
			_buttons.append(btn)
			$DialogBox/TextureRect/ChoiceContainer.add_child(btn)
			dialog_choice.play()
			
		# '_select_choice' is a function that will take the index of
		# your selection and continue the story.
		#_select_choice(0)
	else:
		# This code runs when the story reaches it's end.
		print("The End")
		yield(get_tree().create_timer(2.0), "timeout")
		tree_container.visible = false
		npc_container.visible = false
		player_container.visible = false
		var start_position = dialog_box.rect_position
		var end_position = dialog_final_position + Vector2(0,200)
		tween.interpolate_property(
		dialog_box, "rect_position",
		start_position, end_position,
		1.0, Tween.TRANS_CUBIC, Tween.EASE_IN
		)
		tween.interpolate_property(
		dialog_box, "modulate:a",
		1.0, 0.0,
		1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		tween.start()
		yield(tween, "tween_completed")
		yield(get_tree().create_timer(1), "timeout")
#		queue_free()
		get_tree().change_scene("res://Scenes/Game/FinalScene.tscn")


func _choose_index(btn):
	choice_sound.play()
	var index = _buttons.find(btn)
	if index != -1:
		_select_choice(index)
	

func _select_choice(index):
	for button in $DialogBox/TextureRect/ChoiceContainer.get_children():
		$DialogBox/TextureRect/ChoiceContainer.remove_child(button)
		_buttons.erase(button)
	_ink_player.choose_choice_index(index)
	_continue_story()


# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
# 	pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by putting adding them in the array.
# func _observe_variables():
# 	_ink_player.observe_variables(["var1", "var2"], self, "_variable_changed")
#
#
# func _variable_changed(variable_name, new_value):
# 	print("Variable '%s' changed to: %s" %[variable_name, new_value])

#
func _on_Tween_tween_completed(object, key):
	finished = true

func get_current_speaker(tags: Array) -> String:
	for tag in tags:
		if tag.begins_with("speaker:"):
			return tag.split(":")[1].strip_edges()
	return "Player"  # Default to Player if no speaker tag

func _update_speaker_ui(speaker_name: String):
	npc_container.visible = false
	player_container.visible = false
	tree_container.visible = false

	match speaker_name:
		"Old Man":
			npc_container.visible = true
			old_man_sound.play()
		"Player":
			player_container.visible = true
		"Narrator":
			npc_container.visible = true
			player_container.visible = true
		"Tree":
			tree_container.visible = true
			tree_sound.play()
		_:
			player_container.visible = true  # Default fallback
