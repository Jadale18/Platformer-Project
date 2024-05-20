extends Control

func _ready():
	$CanvasLayer/AnimatedSprite2D.play("default")

func _process(delta):
	if Input.is_action_just_pressed("Inventory") and Global.pausable:
		$CanvasLayer.show()
		get_tree().paused = true
		$CanvasLayer/Buttons/ShoesMenuButt.grab_focus()

		

func _on_shoes_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/ShoesMenu.show()
	$CanvasLayer/GridMenus/ShoesMenu/ShoesGrid.get_child(0).grab_focus()


func _on_close_button_pressed():
	$CanvasLayer/ColorRect.hide()
	$CanvasLayer/GridMenus/ShoesMenu.hide()
	$CanvasLayer/GridMenus/GarmentsMenu.hide()
	$CanvasLayer/GridMenus/WeaponsMenu.hide()
	$CanvasLayer/GridMenus/HatsMenu.hide()


func _on_garments_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/GarmentsMenu.show()
	$CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid.get_child(0).grab_focus()

func _on_hats_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/HatsMenu.show()

func _on_weapons_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/WeaponsMenu.show()


func _on_return_butt_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false

func _on_l_shoe_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/Button.icon

func _on_m_shoe_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/Button2.icon
