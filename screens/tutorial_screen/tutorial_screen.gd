extends "res://screens/basic_screen.gd"
var tutor_part = 1
func _on_next_up():
	if $Animator.is_playing():
		$Animator.seek($Animator.get_current_animation_length())
	else:
		if tutor_part < $Animator.get_animation_list().size() -1:
			tutor_part += 1
			$Animator.play($Animator.get_animation_list()[tutor_part])
		else:
			$Dialogue/Button.disabled = true
			change_scene()