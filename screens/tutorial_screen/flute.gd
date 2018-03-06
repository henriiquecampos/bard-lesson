extends Sprite
const PITCHES = [1.0, 1.25, 1.50]

func _ready():
	set_process_input(false)

func play_flute(pitch):
	var bus = AudioServer.get_bus_index($SFX.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(PITCHES[pitch])
	$SFX.play()
	
func _input(event):
	if (event is InputEventKey):
		var p = 0
		var k = ""
		print(InputMap.get_action_list("interact").size())
		if PITCHES.size() > InputMap.get_action_list("interact").size():
			InputMap.action_add_event("interact", event)

		for e in InputMap.get_action_list("interact"):
			if e.as_text() == event.as_text():
				p = (InputMap.get_action_list("interact").find(e))
				k = e.as_text().to_lower()

		if event.is_action_pressed("interact"):
			play_flute(p)
			$Keys.get_child(p).set_pressed(true)
			$Keys.get_child(p).get_node("Letter").set_text(k)
		elif event.is_action_released("interact"):
			$SFX.stop()
			$Keys.get_child(p).set_pressed(false)