extends Area2D

signal key_collected
onready var sound = $PickupSound
onready var tween = $Tween

func _on_Collectible_body_entered(body):
	if body.name == "Player":
		sound.play()
		tween.interpolate_property(
			self, "scale", scale * 1.3, 0.2, 
			Tween.TRANS_BACK, Tween.EASE_OUT
		)
		tween.interpolate_property(
			self, "modulate:a", 1, 0, 0.2,
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		tween.start()
		yield(tween, "tween_completed")
		emit_signal("key_collected")
		queue_free()
