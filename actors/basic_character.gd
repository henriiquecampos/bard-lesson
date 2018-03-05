extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 50
const MAX_SPEED = 400
const JUMP_HEIGHT = -1400
var velocity = Vector2()
var can_jump = true
var falling = false
var can_move = true
onready var init_scale = $Sprites.get_scale()

enum STATES{IDLE, WALK, JUMP}
var current_state = IDLE setget set_current_state, get_current_state

func _physics_process(delta):
	if !can_move:
		return
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, UP)
	
	if is_on_floor():
		can_jump = true
	else:
		if !can_jump and !falling and velocity.y >= 0:
			falling = true
			$Animator.play("fall")
	
func apply_jump():
	if is_on_floor():
		set_current_state(JUMP)
		velocity.y = JUMP_HEIGHT
		can_jump = false
		
func cancel_jump():
	if !can_jump:
		if velocity.y <= 0:
			velocity.y = 0
		
func walk(direction, speed = MAX_SPEED):
	velocity.x = speed * direction
	
	if direction != 0 and can_jump:
		set_current_state(WALK)
	else:
		if can_jump:
			set_current_state(IDLE)
	if direction != 0:
		$Sprites.scale = Vector2(init_scale.x *-1, init_scale.y) if direction < 0 else init_scale

func set_current_state(state):
	if current_state == state:
		return
	if state == IDLE:
		$Animator.play("rest")
		falling = false
	elif state == WALK:
		$Animator.play("walk")
		falling = false
	elif state == JUMP:
		$Animator.play("jump")
	current_state = state

func get_current_state():
	return(current_state)