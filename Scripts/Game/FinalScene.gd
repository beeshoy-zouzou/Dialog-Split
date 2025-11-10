extends Control



onready var exit_button = $ExitButton
onready var background = $Background
onready var tween = $Tween
onready var fade_overlay = $FadeOverlay
onready var ending_audio = $EndingAudio

func _ready():
	fade_overlay.color = Color(0,0,0,1)
	
	ending_audio.volume_db = -40
	ending_audio.play()
	tween.interpolate_property(
		fade_overlay, "color:a",
		1.0, 0.0, 1.5,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	
	
	tween.interpolate_property(
		ending_audio, "volume_db",
		-40, -8, 1.5,
		Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	tween.start()

func _on_Exit_Button_pressed():
	tween.interpolate_property(
		fade_overlay, "color:a",
		0.0, 1.0, 1.0,
		Tween.TRANS_SINE, Tween.EASE_IN
	)
	tween.start()
	yield(tween, "tween_completed")
	get_tree().change_scene("res://Scenes/Main_Menu.tscn") 














