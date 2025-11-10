extends Node2D


onready var anim_sprite = $AnimatedSprite
onready var collision_shape = $StaticBody2D/CollisionShape2D
onready var static_body = $StaticBody2D
onready var area_shape = $Area2D/CollisionShape2D 
onready var area = $Area2D
onready var open_door = $OpenDoor
onready var explosion_sound = $ExplosionSound
onready var explosion = $Explosion

var is_open = false
var is_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	set_process(false) # Replace with function body.





func _on_Area2D_body_entered(body):
	print("Area2D entered by: ", body.name, " (type: ", typeof(body), ")")
	if body.name == "Player" and GameState.has_key:
		print("it got here")
		unlock()

func unlock():
	if is_open:
		return
	is_open = true
	
	# Play Sound
	
	if open_door:
		open_door.play()
	
	anim_sprite.play("unlock")

	collision_shape.disabled = true
	area_shape.disabled = true
	yield(get_tree().create_timer(2.0), "timeout")
	explode()
	area.queue_free()
	
	


func _on_AnimatedSprite_animation_finished():
	queue_free() # Replace with function body.


func explode():
	if is_destroyed:
		return
	is_destroyed = true
	print("BOOM! Door exploded!")
	
	if explosion_sound:
		explosion_sound.play()
		explosion.emitting = true
		anim_sprite.visible = false
		
	collision_shape.disabled = true
	area_shape.disabled = true
	
	yield(get_tree().create_timer(1.5), "timeout")
	queue_free()
	
func activate():
	visible = true
	collision_shape.disabled = false
	area_shape.disabled = false
	print("Door activated!")
