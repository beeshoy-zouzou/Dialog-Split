
extends KinematicBody2D


enum DIALOG_STATE {GREETING, FIRST_CHOIE, WAIT_SECOND_CHOICE, SECOND_CHOICE, COMPLETE}
var current_state = DIALOG_STATE.GREETING
var can_interact = false
var player_in_range = false

onready var interact = $Interact as Area2D
onready var animatedsprite = $AnimatedSprite as AnimatedSprite


# Dialog content

var npc_greeting = "Greetings traveler! How can I help you today?"
var player_choices_1 = ["I am just moving around", "I am looking for a way out of the forest"]
var npc_responses = {
	0:"Ah yes, the old path still stands strong.", 
	1: "Beware the dark woods, friend."
	}

var player_choices_2 = ["Take the river path", "Enter the dark forest"]

func ready():
	interact.connect("body_entered", self, "_on_Interact_body_entered")
	interact.connect("body_exited", self, "_on_Interact_body_existed")
	DialogSystem.connect("dialog_ended", self, "_on_dialog_ended")
	animatedsprite.play("idle_back")

func _on_Interact_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		can_interact = true
		GameUI.interaction_prompt.visible = true
		if not DialogSystem.is_active():
			DialogSystem.last_player_choice = -1

func _on_Interact_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		can_interact = false
		GameUI.interaction_prompt.visible = false
		if DialogSystem.is_active:
			DialogSystem.end_dialog()
			animatedsprite.play("idle_back")

func _input(event):
	if event.is_action_pressed("talk") and can_interact and not DialogSystem.is_active():
		GameUI.hide_interaction_prompt()
		start_dialog()

func start_dialog():
	animatedsprite.play("idle_right")
	var dialog_sound = GameUI.get_node("DialogStartSound")
	if dialog_sound:
		dialog_sound.play()
	else:
		print("no sound detected")
	DialogSystem.start_dialog(self)
#	update_dialog()

func update_dialog():
	match current_state:
		DIALOG_STATE.GREETING:
			if not player_in_range:
				return
			DialogSystem.show_npc_message(npc_greeting)
			yield(DialogSystem, "npc_text_complete")
			print("NPC: Finished showing text")
			DialogSystem.show_player_choices(player_choices_1)
			print("NPC: Showing player choices")
			current_state = DIALOG_STATE.FIRST_CHOIE
		
		DIALOG_STATE.FIRST_CHOIE:
			if not player_in_range:
				return
			if DialogSystem.last_player_choice in npc_responses:
				DialogSystem.show_npc_message(npc_responses[DialogSystem.last_player_choice])
				yield(DialogSystem, "npc_text_complete")
				DialogSystem.show_player_choices(player_choices_2)
				current_state = DIALOG_STATE.WAIT_SECOND_CHOICE
#				current_state = DIALOG_STATE.SECOND_CHOICE
		
		DIALOG_STATE.WAIT_SECOND_CHOICE:
			if DialogSystem.last_player_choice == -1:
				return
			current_state = DIALOG_STATE.SECOND_CHOICE
			update_dialog()
		DIALOG_STATE.SECOND_CHOICE:
			if not player_in_range:
				return
			animatedsprite.play("idle_back")
			DialogSystem.show_npc_message("Safe travels, adventurer!")
			yield(DialogSystem, "npc_text_complete")
#			yield(get_tree().create_timer(1.0), "timeout")
			DialogSystem.end_dialog()
			current_state = DIALOG_STATE.COMPLETE
			
			# Handle final choice
			match DialogSystem.last_player_choice:
				
				0: 
					var main_scene = get_tree().get_root().get_node("World")
					if main_scene and main_scene.has_method("open_chest"):
						main_scene.open_chest(true, true, true)
#					

				1: 
					var main_scene = get_tree().get_root().get_node("World")
					if main_scene and main_scene.has_method("open_chest"):
						main_scene.show_dark_forest()
#					
		
		
		

func _on_dialog_ended():
	if not player_in_range:
		animatedsprite.play("idle_back")



