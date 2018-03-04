extends Area2D
signal picked_up(who)
func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	if body.is_in_group("players"):
		emit_signal("picked_up", self)
		queue_free()