class_name message
extends Panel


onready var key_text = $KeyText as Label
onready var tween = $Tween as Tween
signal message_finished

func show_message(text):
	key_text.text = text
	modulate.a = 0
	visible = true
	rect_position.y += 20
	tween.interpolate_property(
		self, "modulate:a", 0, 1, 0.5,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	tween.interpolate_property(
		self, "rect_position:y", rect_position.y, 
		rect_position.y - 20, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT
	)
	tween.start()
	yield(get_tree().create_timer(2.5), "timeout")
	
	tween.interpolate_property(
		self, "modulate:a", 1, 0, 0.5,
		Tween.TRANS_SINE, Tween.EASE_IN
	)
	tween.start()
	yield(tween, "tween_completed")
	visible = false
	emit_signal("message_finished")
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
