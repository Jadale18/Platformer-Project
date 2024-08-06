extends Control

var checking = false
	

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed and checking:
		print('aaaaa')
