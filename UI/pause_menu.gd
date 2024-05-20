extends Control

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Pause") and Global.pausable and not paused:
		$CanvasLayer.show()
		get_tree().paused = true
		paused = true
	elif Input.is_action_just_pressed("Pause") and paused:
		$CanvasLayer.hide()
		get_tree().paused = false
		paused = false
		

func _on_button_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false
	paused = false
