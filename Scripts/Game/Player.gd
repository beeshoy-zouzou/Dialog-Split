extends KinematicBody2D

#onready var animatedsprite = $AnimatedSprite 
#export(int) var speed = 100
#var motion = Vector2(0,0)
#
#func _ready():
#	set_process(true)
#	animatedsprite.play("idle_left")
#
#func _process(delta):
#	if Input.is_action_pressed("ui_up"):
#		motion.y -= speed * delta
#		animatedsprite.play("walk_front")
#	elif Input.is_action_pressed("ui_down"):
#		motion.y += speed * delta
#		animatedsprite.play("walk_back")
#	elif Input.is_action_pressed("ui_left"):
#		motion.x -= speed * delta
#		animatedsprite.play("walk_left")
#	elif Input.is_action_pressed("ui_right"):
#		motion.x += speed * delta
#		animatedsprite.play("walk_right")
#	else:
#		motion.x = 0
#		motion.y = 0
#
#	motion = move_and_slide(motion)

onready var animatedsprite = $AnimatedSprite
export(int) var speed = 100
var motion = Vector2.ZERO
var last_direction = "left"

func _ready():
	set_physics_process(true)
	animatedsprite.play("idle_left")
	
func _physics_process(delta):
	motion = Vector2.ZERO
	var is_moving = false
	
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
		last_direction = "up"
		is_moving = true
		
	elif Input.is_action_pressed("ui_down"):
		motion.y += 1
		last_direction = "down"
		is_moving = true
		
	elif Input.is_action_pressed("ui_left"):
		motion.x -= 1
		last_direction = "left"
		is_moving = true
	
	elif Input.is_action_pressed("ui_right"):
		motion.x += 1
		last_direction = "right"
		is_moving = true
	
	motion = motion.normalized() * speed
	move_and_slide(motion)
	
	if is_moving == false:
		match last_direction:
			"up":
				animatedsprite.play("idle_back")
			"down":
				animatedsprite.play("idle_front")
			"left":
				animatedsprite.play("idle_left")
			"right":
				animatedsprite.play("idle_right")	
	else:
		match last_direction:
			"up":
				animatedsprite.play("walk_back")
			"down":
				animatedsprite.play("walk_front")
			"left":
				animatedsprite.play("walk_left")
			"right":
				animatedsprite.play("walk_right")	

