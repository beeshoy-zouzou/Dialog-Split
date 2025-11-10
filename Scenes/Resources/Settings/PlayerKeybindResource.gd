class_name PlayerKeybindResource
extends Resource

const MOVE_LEFT : String = "move_left"
const MOVE_RIGHT : String = "move_right"
const JUMP : String = "jump"

export(InputEventKey) var default_move_left_key 
export (InputEventKey) var default_move_right_key 
export (InputEventKey) var default_jump_key 

var move_left_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var jump_key = InputEventKey.new()

func _init():
	if default_move_left_key == null:
		default_move_left_key = InputEventKey.new()
		default_move_left_key.scancode = KEY_A
		default_move_left_key.pressed = true
	
	if default_move_right_key == null:
		default_move_right_key = InputEventKey.new()
		default_move_right_key.scancode = KEY_D
		default_move_right_key.pressed = true
		
	if default_jump_key == null:
		default_jump_key = InputEventKey.new()
		default_jump_key.scancode = KEY_SPACE
		default_jump_key.pressed = true

