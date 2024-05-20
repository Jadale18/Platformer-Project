extends Control

func _ready():
	$CanvasLayer/AnimatedSprite2D.play("default")

func _process(delta):
	if Input.is_action_just_pressed("Inventory") and Global.pausable:
		$CanvasLayer.show()
		get_tree().paused = true

		

func _on_shoes_menu_butt_pressed():
	print('shoe')
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/ShoesMenu.show()


func _on_close_button_pressed():
	$CanvasLayer/ColorRect.hide()
	$CanvasLayer/GridMenus/ShoesMenu.hide()
	$CanvasLayer/GridMenus/GarmentsMenu.hide()
	$CanvasLayer/GridMenus/WeaponsMenu.hide()
	$CanvasLayer/GridMenus/HatsMenu.hide()


func _on_garments_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/GarmentsMenu.show()

func _on_hats_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/HatsMenu.show()

func _on_weapons_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/WeaponsMenu.show()


func _on_return_butt_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false
