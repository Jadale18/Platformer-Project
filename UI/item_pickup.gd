extends Control

func _ready():
	get_tree().paused = true
	

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		print('aaaaa')
