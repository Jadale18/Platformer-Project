extends Control

var current_shoe
var full_item_list = ['LeatherBoots']
var unlocked_item_list = []

func _ready():
	$CanvasLayer/AnimatedSprite2D.play("default")

func _process(delta):
	if Input.is_action_just_pressed("Inventory") and Global.pausable:
		$CanvasLayer.show()
		get_tree().paused = true
		$CanvasLayer/Buttons/ShoesMenuButt.grab_focus()

func _on_items_child_entered_tree(node):
	if node.is_in_group("Shoes"):
		get_node('CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/' + node.name + 'Button').disabled = false

# Button Presses (theres a lot lol)
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

# Button presses for specific items
func _on_leather_shoe_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/LeatherBootsButton.icon
	current_shoe = "LeatherBoots"

