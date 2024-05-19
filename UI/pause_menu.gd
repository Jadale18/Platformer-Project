extends Control

var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
