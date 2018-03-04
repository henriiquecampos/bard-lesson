extends Sprite
const PITCHES = [1.0, 1.25, 1.50]

func _ready():
	set_process(false)
	
func _process(delta):
	$Keys/Z.set_pressed(Input.is_key_pressed(KEY_Z))
	$Keys/X.set_pressed(Input.is_key_pressed(KEY_X))
	$Keys/C.set_pressed(Input.is_key_pressed(KEY_C))
	
	if Input.is_action_just_pressed("interact"):
		if Input.is_key_pressed(KEY_Z):
			play_flute(0)
		elif Input.is_key_pressed(KEY_X):
			play_flute(1)
		elif Input.is_key_pressed(KEY_C):
			play_flute(2)
	if Input.is_action_just_released("interact"):
		$SFX.stop()
	
func play_flute(pitch):
	var bus = AudioServer.get_bus_index($SFX.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(PITCHES[pitch])
	$SFX.play()