extends Node


signal dialog_ended
signal npc_text_complete
signal choices_shown


var is_active = false
var last_player_choice = -1
var current_actor = null

func is_active():
	return is_active

func start_dialog(actor):
	is_active = true
	current_actor = actor
	GameUI.show_dialogue_box()
	yield(GameUI.tween, "tween_completed")
	actor.update_dialog()

func show_npc_message(text):
	GameUI.hide_choice_buttons()
	yield(GameUI.set_npc_text(text), "completed")
	
	emit_signal("npc_text_complete")
	print("Signal emitted: npc_text_complete")

func show_player_choices(options):
	GameUI.set_choice_buttons(options)
	emit_signal("choices_shown")
#	GameUI.set_choice_buttons(options)

func player_chose(choice_index):
	last_player_choice = choice_index
	if current_actor and current_actor.has_method("update_dialog"):
		current_actor.update_dialog()
	else:
		push_error("Missing current_actor or update_dialog method")

func end_dialog():
	is_active = false
	yield(get_tree().create_timer(2.0), "timeout")
	GameUI.hide_dialogue_box()
	yield(GameUI.tween, "tween_completed")
	
	last_player_choice = -1
	emit_signal("dialog_ended")














