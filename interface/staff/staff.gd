extends HBoxContainer
const COLORS = [Color("bc5fd3"), Color("8d5fd3"), Color("37c871")]
const DURATIONS = [preload("res://interface/note_duration/16.png"),
preload("res://interface/note_duration/8.png"), preload("res://interface/note_duration/4.png")] 
func add_note(pitch, duration):
	var t = TextureRect.new()
	if duration == 16:
		t.texture = DURATIONS[0]
	elif duration == 8:
		t.texture = DURATIONS[1]
	elif duration == 4:
		t.texture = DURATIONS[2]
	t.stretch_mode = t.STRETCH_KEEP_CENTERED
	t.self_modulate = COLORS[pitch]
	add_child(t)