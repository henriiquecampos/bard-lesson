extends Node2D

onready var objectives = $Objectives.get_child_count()
signal score_increased(amount)

func _ready():
	#Portal is the Node responsible for verifying if the player reached
	#the end of the level
	$Portal.connect("body_entered", self, "_portal_body_entered")
	for o in $Objectives.get_children():
		o.connect("tree_exited", self, "check_objective", [o])
		
func check_objective(objective):
	#Decrease the current amount of objects in this level when they
	#exit the scene tree, if the object has a score method, emits a
	#signal with the amount to be scored
	if objective.has_method("score"):
		emit_signal("score_increased", [objective.score])
	objectives -= 1
	
func _portal_body_entered(body):
	if body.is_in_group("players"):
		check_completion()
		
func check_completion():
	#If the minimum amount of objectives was accomplished by the player
	#resets the player to its rest/idle pose, locks its movement and 
	#change the screen based on "res://screens/basic_screen.gd" behavior
	if $Objectives.get_child_count() == 0:
		$Player.resume()
		$Player.set_physics_process(false)
		$Screen/GameScreen.change_scene()
	else:
		$Screen/GameScreen/UI/Staff/Animator.play("miss")

func _on_void_entered( body ):
	if body.is_in_group("players"):
		get_tree().reload_current_scene()
