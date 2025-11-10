extends CanvasLayer

signal text_shown
signal choices_shown
signal completed

onready var dialog_box = $DialogBox 
onready var interaction_label = $InteractionPrompt/Label as Label
onready var interaction_prompt = $InteractionPrompt
onready var npc_text  = $DialogBox/NPCText as Label
onready var choice_select_sound = $ChoiceSelectSound
onready var tween = $DialogBox/Tween as Tween
onready var choice_buttons = [
	$DialogBox/ChoiceContainer/Choice1,
	$DialogBox/ChoiceContainer/Choice2
] 


func _ready():
	dialog_box.visible = false
	dialog_box.rect_position.y = get_viewport().size.y
	hide_interaction_prompt()
	hide_choice_buttons()
	

	for i in range(choice_buttons.size()):
		if not choice_buttons[i].is_connected("pressed", self, "_on_choice_selected"):
			choice_buttons[i].connect("pressed", self, "_on_choice_selected", [i])


func show_interaction_prompt(text):
	interaction_label.text = text
	interaction_prompt.visible = true
	

func hide_interaction_prompt():
	interaction_prompt.visible = false

func show_dialogue_box():
	dialog_box.visible = true
	var start_y = get_viewport().size.y
	var end_y = start_y - dialog_box.rect_size.y
	tween.interpolate_property(
		dialog_box, "rect_position:y", start_y, end_y, 
		1.0, Tween.TRANS_BACK, Tween.EASE_OUT
	)
	tween.start()
		

func hide_dialogue_box():
	if not dialog_box.visible:
		return
	var start_y = dialog_box.rect_size.y + 200 
	var end_y = get_viewport().size.y

	
	tween.interpolate_property(
		dialog_box, "rect_position:y", start_y , end_y,
		1.0, Tween.TRANS_SINE, Tween.EASE_IN
	)
	tween.start()
	yield(tween, "tween_completed")
	dialog_box.visible = false
	

func set_npc_text(text):
	if tween.is_active():
		tween.stop(npc_text, "percent_visible")
		
	npc_text.text = text
	npc_text.percent_visible = 0
	tween.interpolate_property(
		npc_text, "percent_visible", 0, 1, 1.0, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
#	emit_signal("text_shown")
	emit_signal("completed")
#	return null

#func show_choices_after_text():
#	yield(tween, "tween_completed")
#	emit_signal("text_shown")
#	yield(get_tree().create_timer(1.0), "timeout")
#	emit_signal("choices_shown")

func set_choice_buttons(options):
	for i in range(choice_buttons.size()):
		choice_buttons[i].text = options[i]
		choice_buttons[i].visible = true
	emit_signal("choices_shown")

func hide_choice_buttons():
	for button in choice_buttons:
		button.visible = false


func _on_choice_selected(choice_index):
	
	if choice_select_sound:
		choice_select_sound.play()
	if DialogSystem:
		DialogSystem.player_chose(choice_index)
	else:
		push_error("DialogSystem autoload not found!")











