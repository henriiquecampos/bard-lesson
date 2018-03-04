extends Node2D

onready var t = $Tween

func tutorial(part):
	if part == 1:
		part_01()
	
func part_01():
	t.interpolate_property(self, "position", get_position(), Vector2(309, 370), 
		2.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	t.start()
	yield(t, "tween_completed")
	t.interpolate_property($Arm/OKHand, "rotation_degrees", 0, -14,
		0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	t.start()
	yield(t, "tween_completed")
	t.interpolate_property($Arm/OKHand, "rotation_degrees", -14, 10,
		1.0, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	t.start()
	yield(t, "tween_completed")
	$Arm/OKHand/hat.hide()
	$"../Bard/Body/Head".set_region_rect(Rect2(9, 3, 83, 89))
	t.interpolate_property(self, "position", get_position(), Vector2(-80, 370), 
		2.0, Tween.TRANS_BACK, Tween.EASE_IN)
	t.start()
	yield(t, "tween_completed")