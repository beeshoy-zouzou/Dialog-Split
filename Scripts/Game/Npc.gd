extends Area2D


onready var npc = get_parent().get_node("AnimatedSprite")
var player_in_range = false
var is_talking = false
var dialogue_index = 0
var choice_phase = false

var greeting_lines = [
	"Hello!",
	"Which story",
	"Press 1",
	"Press 2"
]

func _ready():
	npc.play("idle_back")
	set_process(true)

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("talk"):
		if not is_talking :
			is_talking = true
			dialogue_index = 0
			show_dialogue()
		else:
			advance_dialogue()

func _on_Interact_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_Interact_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		is_talking = false
		dialogue_index = 0
		npc.play("idle_back")
		hide_dialogue()

func show_dialogue():
	print(greeting_lines[dialogue_index])

func advance_dialogue():
	dialogue_index += 1
	if dialogue_index < greeting_lines.size():
		show_dialogue()
	else:
		print("Loading story scene")
#		get_tree().change_scene("res://Scenes/DialogSystemScene/DialogSystem.tscn")

func hide_dialogue():
	print("Dialogue ended.")
