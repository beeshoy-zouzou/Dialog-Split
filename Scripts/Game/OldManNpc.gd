extends KinematicBody2D


onready var anim_sprite = $AnimatedSprite
export(NodePath) var message_panel_path
var message_panel
var can_interact = false
var has_spoken = false
var player_in_area = false  


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite.play("idle")
	message_panel = get_node(message_panel_path)
	message_panel.connect("message_finished", self, "_on_message_finished")


func _input(event):
	if can_interact and event.is_action_pressed("talk"):
		GameUI.hide_interaction_prompt()
		transition_to_dialog_scene()


func _on_InteractionArea_body_entered(body):
	if body.name == "Player" and not has_spoken:
		player_in_area = true
		message_panel.show_message("You've done well, traveler. The way out is near — but your choice still lies ahead.")

func _on_message_finished():
	if player_in_area and not has_spoken:
		GameUI.show_interaction_prompt("Press E      to talk")
		can_interact = true

func transition_to_dialog_scene():
	has_spoken = true
	var dialog_scene = preload("res://Scenes/DialogSystemScene/DialogSystem.tscn").instance()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(dialog_scene)
	get_tree().current_scene = dialog_scene


func _on_InteractionArea_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		GameUI.hide_interaction_prompt()
		can_interact = false
