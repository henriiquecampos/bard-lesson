extends "res://actors/basic_character.gd"
var can_move = true
func _physics_process(delta):
	if !can_move:
		return
	if Input.is_action_just_pressed("ui_up"):
		apply_jump()
	if Input.is_action_just_released("ui_up"):
		cancel_jump()
		
	if Input.is_action_pressed("ui_right"):
		walk(1)
	elif Input.is_action_pressed("ui_left"):
		walk(-1)
	else:
		walk(0)