extends Control

var current_shoe = null
var current_garment = null
var current_hat = null
var current_weapon = null
signal equipment_change(type)

var full_item_list = ['LeatherBoots']
var unlocked_item_list = []

var last_focused

var double_jump = true
var dash = true
var wall_jump = true


func _ready():
	$CanvasLayer/AnimatedSprite2D.play("default")

func _process(delta):
	if Input.is_action_just_pressed("Inventory") and Global.pausable:
		$CanvasLayer.show()
		get_tree().paused = true
		$CanvasLayer/Buttons/ShoesMenuButt.grab_focus()

# On Item Pickup Enable Button
func _on_items_child_entered_tree(node):
	if node.is_in_group("Shoes"):
		get_node('CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/' + node.name + 'Button').disabled = false
		unlocked_item_list.append(node.name)
	elif node.is_in_group("Garments"):
		get_node('CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid/' + node.name + 'Button').disabled = false
		unlocked_item_list.append(node.name)
	elif node.is_in_group("Hats"):
		get_node('CanvasLayer/GridMenus/HatsMenu/HatsGrid/' + node.name + 'Button').disabled = false
		unlocked_item_list.append(node.name)
	elif node.is_in_group("Weapons"):
		get_node('CanvasLayer/GridMenus/WeaponsMenu/WeaponsGrid/' + node.name + 'Button').disabled = false
		unlocked_item_list.append(node.name)

# Button Presses (theres a lot lol)
func _on_shoes_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/ShoesMenu.show()
	$CanvasLayer/GridMenus/ShoesMenu/ShoesGrid.get_child(0).grab_focus()
	last_focused = $CanvasLayer/Buttons/ShoesMenuButt

func _on_close_button_pressed():
	$CanvasLayer/ColorRect.hide()
	$CanvasLayer/GridMenus/ShoesMenu.hide()
	$CanvasLayer/GridMenus/GarmentsMenu.hide()
	$CanvasLayer/GridMenus/WeaponsMenu.hide()
	$CanvasLayer/GridMenus/HatsMenu.hide()
	last_focused.grab_focus()

func _on_garments_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/GarmentsMenu.show()
	$CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid.get_child(0).grab_focus()
	last_focused = $CanvasLayer/Buttons/GarmentsMenuButt

func _on_hats_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/HatsMenu.show()
	$CanvasLayer/GridMenus/HatsMenu/HatsGrid.get_child(0).grab_focus()
	last_focused = $CanvasLayer/Buttons/HatsMenuButt

func _on_weapons_menu_butt_pressed():
	$CanvasLayer/ColorRect.show()
	$CanvasLayer/GridMenus/WeaponsMenu.show()
	$CanvasLayer/GridMenus/WeaponsMenu/WeaponsGrid.get_child(0).grab_focus()
	last_focused = $CanvasLayer/Buttons/WeaponsMenuButt

func _on_return_butt_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false

# Button presses for specific items

# Shoes
func _on_leather_shoe_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/LeatherBootsButton.icon
	current_shoe = "LeatherBoots"
	emit_signal("equipment_change","Shoe")

func _on_metal_boots_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/MetalBootsButton.icon
	current_shoe = "MetalBoots"
	emit_signal("equipment_change", "Shoe")

# Garments
func _on_leather_garment_button_pressed():
	$CanvasLayer/Panels/GarmentPanel/TextureRect.texture = $CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid/LeatherGarmentButton.icon
	current_garment = "LeatherGarment"
	emit_signal("equipment_change", "Garment")

func _on_metal_garment_button_pressed():
	$CanvasLayer/Panels/GarmentPanel/TextureRect.texture = $CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid/MetalGarmentButton.icon
	current_garment = "MetalGarment"
	emit_signal("equipment_change", "Garment")

# Hats
func _on_leather_hat_button_2_pressed():
	$CanvasLayer/Panels/HatPanel/TextureRect.texture = $CanvasLayer/GridMenus/HatsMenu/HatsGrid/LeatherHatButton.icon
	current_hat = "LeatherHat"
	emit_signal("equipment_change", "Hat")

func _on_metal_hat_button_pressed():
	$CanvasLayer/Panels/HatPanel/TextureRect.texture = $CanvasLayer/GridMenus/HatsMenu/HatsGrid/MetalHatButton.icon
	current_hat = "MetalHat"
	emit_signal("equipment_change", "Hat")

# Weapons

func _on_wood_sword_pressed():
	$CanvasLayer/Panels/WeaponPanel/TextureRect.texture = $CanvasLayer/GridMenus/WeaponsMenu/WeaponsGrid/WoodSwordButton.icon
	current_weapon = "WoodSword"
	emit_signal("equipment_change", "Weapon")

func _on_metal_sword_button_pressed():
	$CanvasLayer/Panels/WeaponPanel/TextureRect.texture = $CanvasLayer/GridMenus/WeaponsMenu/WeaponsGrid/MetalSwordButton.icon
	current_weapon = "MetalSword"
	emit_signal("equipment_change", "Weapon")
