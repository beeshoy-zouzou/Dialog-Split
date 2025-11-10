extends Control

onready var dialog_text = $DialogText as RichTextLabel
onready var tween = $Tween as Tween
onready var next_indicator = $"next-indicator" 

var dialog = [
	'Hello there, this dialog system is amazing',
	'If you like it, you can pay; just kidding',
	'but if you do not, you should pay, no joke'
]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

func _process(delta):
	next_indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
		

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		dialog_text.bbcode_text = dialog[dialog_index]
		dialog_text.percent_visible = 0
		tween.interpolate_property(
			dialog_text, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		tween.start()
	else:
		queue_free()
	dialog_index +=1


func _on_Tween_tween_completed(object, key):
	finished = true
