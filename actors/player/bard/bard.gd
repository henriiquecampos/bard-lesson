extends "res://actors/player/player_character.gd"
const PITCHES = [1.0, 1.25, 1.50]
var object = null
const NOTE = preload("res://interface/note_duration/note.tscn")
var note = null
var check = false

signal played_note(pitch, duration)

func _ready():
	connect("played_note", get_tree().get_nodes_in_group("staff")[0], "add_note")

func interact(p):
	#Access the pitch effect and modify it based on the pitch the player
	#is using in the interaction
	var bus = AudioServer.get_bus_index($Flute.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(PITCHES[p])
	$Flute.play()
	if object != null:
		check = check_pitch(PITCHES[p], object.pitch)
		if !check:
#			miss()
			object.miss()
	
func resume():
	#Returns the character to it's rest/idle position and re-enable its
	#movement and interaction behaviors
	$Animator.play("rest")
	$Flute.stop()
	set_current_state(IDLE)
	
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
		
func _input(event):
	if !(event is InputEventKey):
		return
	var p = 0

	for e in InputMap.get_action_list("interact"):
		if e.as_text() == event.as_text():
			p = (InputMap.get_action_list("interact").find(e))

	if event.is_action_pressed("interact") and is_on_floor():
		can_move = false
		$Animator.play("flute")
		interact(p)
		note = NOTE.instance()
		note.position += Vector2(32, -150)
		add_child(note)
		note.set_modulate(note.COLORS[p])
		
	elif event.is_action_released("interact"):
		$Flute.stop()
		can_move = true
		if note == null:
			return
		var duration = note.duration
		note.finished()
		note = null
		
		if object != null:
			if check_duration(duration, object.note_duration) and check:
				success()
				object.success()
				emit_signal("played_note", p, duration)
			else:
				miss()
				object.miss()
		else:
			resume()
	