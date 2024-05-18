extends Control



func _on_start_pressed():
	get_tree().root.add_child(Global.world_scene)
	get_node("/root/MainMenu").queue_free()
	Global.world_scene = preload('res://World/world.tscn').instantiate()


func _on_quit_pressed():
	get_tree().quit()
