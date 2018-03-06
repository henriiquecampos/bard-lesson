extends "res://screens/basic_screen.gd"

func _process(delta):
	$"CreditsViewport/ParallaxBackground/ParallaxLayer".motion_offset.y -= 30 * delta
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("jump"):
		change_scene()
