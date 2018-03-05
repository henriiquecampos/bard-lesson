extends "res://actors/player/player_character.gd"

var object = null
const NOTE = preload("res://interface/note_duration/note.tscn")
var note = null
enum KEYS{Z, X, C}
var key = 0
var check = false

signal played_note(pitch, duration)

func _ready():
	connect("played_note", get_tree().get_nodes_in_group("staff")[0], "add_note")
func _process(delta):
	#Start the interaction if it can, then check for which pitch the 
	#player is trying to use in the interaction
	if Input.is_action_just_pressed("interact") and current_state != JUMP:
		can_move = false
		$Animator.play("flute")
		var pitch = 0.0
		note = NOTE.instance()
		note.position += Vector2(32, -150)
		if Input.is_key_pressed(KEY_Z):
			note.set_modulate(note.COLORS[Z])
			pitch = 1.0
			key = Z
		elif Input.is_key_pressed(KEY_X):
			note.set_modulate(note.COLORS[X])
			pitch = 1.25
			key = X
		elif Input.is_key_pressed(KEY_C):
			note.set_modulate(note.COLORS[C])
			pitch = 1.50
			key = C
		add_child(note)
		interact(pitch)
		if object != null:
			check = check_pitch(pitch, object.pitch)
			if !check:
				miss()
				object.miss()
	if Input.is_action_just_released("interact"):
		can_move = true
		if note == null:
			return
		var pitch = key
		var duration = note.duration
		note.finished()
		note = null
			
		if object != null:
			if check_duration(duration, object.note_duration) and check:
				success()
				object.success()
				emit_signal("played_note", pitch, duration)
			elif check:
				miss()
				object.miss()
				object = null
		else:
			resume()
		
func interact(p):
	#Access the pitch effect and modify it based on the pitch the player
	#is using in the interaction
	var bus = AudioServer.get_bus_index($Flute.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(p)
	$Flute.play()
	
func resume():
	#Returns the character to it's rest/idle position and re-enable its
	#movement and interaction behaviors
	$Animator.play("rest")
	$Flute.stop()
	
func miss():
	#Plays a failing animation on both the player and the object he is
	#interacting with, in this case "res://actors/birds/bird.gd" then
	#resume the player's character
	$Animator.play("miss")
	yield($Animator, "animation_finished")
	resume()
	
func success():
	$Flute.stop()
	$Animator.play("success")
	yield($Animator, "animation_finished")
	resume()

func check_pitch(player, other):
	#Verifies if pitches match
	if player == other:
		return(true)
	else:
		return(false)
		
func check_duration(player, other):
	#Verifies if durations match
	if player == other:
		return(true)
	else:
		return(false)