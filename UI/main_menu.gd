extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()


func _on_start_pressed():
	get_tree().root.add_child(Global.world_scene)
	Global.pausable = true
	get_node("/root/MainMenu").queue_free()
	Global.world_scene = preload('res://World/world.tscn').instantiate()


func _on_quit_pressed():
	get_tree().quit()
