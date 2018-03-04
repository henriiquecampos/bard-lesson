tool
extends Node2D

export var count_time = false setget count_time

func count_time(value):
	if !Engine.is_editor_hint():
		return
	count_time = value
	
	if value:
		var total = 0.0
		for b in get_children():
			total += b.duration
			print(total)