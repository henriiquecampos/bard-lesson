extends "res://screens/basic_screen.gd"

func _ready():
	if !bgm.is_playing():
		bgm.play()
	$Start.grab_focus()