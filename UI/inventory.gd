extends Control

var current_shoe = null
var current_garment = null
var current_hat = null
var current_weapon = null
signal equipment_change(type, vible)
signal equipment_visibility_changed(type, vible)

var full_item_list = ['LeatherBoots']
var unlocked_item_list = []

var last_focused

var double_jump = true
var dash = true
var wall_jump = true


func _ready():
	$CanvasLayer/Flippables/AnimatedSprite2D.play("Rest")
	$CanvasLayer/Flippables/AnimationPlayer.play("Rest")

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
func _on_none_shoe_pressed():
	$CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.button_pressed = true
	$CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.disabled = true
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = null
	$CanvasLayer/Flippables/LBoot.texture = null
	$CanvasLayer/Flippables/RBoot.texture = null
	$CanvasLayer/Flippables/LeftFoot.visible = true
	$CanvasLayer/Flippables/RightFoot.visible = true
	current_shoe = null
	emit_signal("equipment_change","Shoe", null)

func _on_leather_shoe_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/LeatherBootsButton.icon
	$CanvasLayer/Flippables/LBoot.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/LeatherBootsButton/Left.texture
	$CanvasLayer/Flippables/RBoot.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/LeatherBootsButton/Right.texture
	if $CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.button_pressed:
		$CanvasLayer/Flippables/LeftFoot.visible = false
		$CanvasLayer/Flippables/RightFoot.visible = false
	$CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.disabled = false
	current_shoe = "LeatherBoots"
	emit_signal("equipment_change","Shoe", $CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.button_pressed)

func _on_metal_boots_button_pressed():
	$CanvasLayer/Panels/ShoesPanel/TextureRect.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/MetalBootsButton.icon
	$CanvasLayer/Flippables/LBoot.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/MetalBootsButton/Left.texture
	$CanvasLayer/Flippables/RBoot.texture = $CanvasLayer/GridMenus/ShoesMenu/ShoesGrid/MetalBootsButton/Right.texture
	if $CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.button_pressed:
		$CanvasLayer/Flippables/LeftFoot.visible = false
		$CanvasLayer/Flippables/RightFoot.visible = false
	$CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.disabled = false
	current_shoe = "MetalBoots"
	emit_signal("equipment_change", "Shoe", $CanvasLayer/Panels/ShoesPanel/ShoesCheckButton.button_pressed)

# Garments
func _on_none_garment_pressed():
	$CanvasLayer/Panels/GarmentPanel/GarmentCheckButton.button_pressed = true
	$CanvasLayer/Panels/GarmentPanel/GarmentCheckButton.disabled = true
	$CanvasLayer/Panels/GarmentPanel/TextureRect.texture = null
	$CanvasLayer/Flippables/Garment.texture = null
	current_garment = null
	emit_signal("equipment_change", "Garment", null)

func _on_leather_garment_button_pressed():
	$CanvasLayer/Panels/GarmentPanel/TextureRect.texture = $CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid/LeatherGarmentButton.icon
	$CanvasLayer/Flippables/Garment.texture = $CanvasLayer/Panels/GarmentPanel/TextureRect.texture
	$CanvasLayer/Panels/GarmentPanel/GarmentCheckButton.disabled = false
	current_garment = "LeatherGarment"
	emit_signal("equipment_change", "Garment", null)

func _on_metal_garment_button_pressed():
	$CanvasLayer/Panels/GarmentPanel/TextureRect.texture = $CanvasLayer/GridMenus/GarmentsMenu/GarmentsGrid/MetalGarmentButton.icon
	$CanvasLayer/Flippables/Garment.texture = $CanvasLayer/Panels/GarmentPanel/TextureRect.texture
	$CanvasLayer/Panels/GarmentPanel/GarmentCheckButton.disabled = false
	current_garment = "MetalGarment"
	emit_signal("equipment_change", "Garment", null)

# Hats
func _on_none_hat_pressed():
	$CanvasLayer/Panels/HatPanel/HatCheckButton.button_pressed = true
	$CanvasLayer/Panels/HatPanel/HatCheckButton.disabled = true
	$CanvasLayer/Panels/HatPanel/TextureRect.texture = null
	$CanvasLayer/Flippables/Hat.texture = null
	current_hat = null
	emit_signal("equipment_change", "Hat", null)
	
func _on_leather_hat_button_2_pressed():
	$CanvasLayer/Panels/HatPanel/TextureRect.texture = $CanvasLayer/GridMenus/HatsMenu/HatsGrid/LeatherHatButton.icon
	$CanvasLayer/Flippables/Hat.texture = $CanvasLayer/Panels/HatPanel/TextureRect.texture
	$CanvasLayer/Panels/HatPanel/HatCheckButton.disabled = false
	current_hat = "LeatherHat"
	emit_signal("equipment_change", "Hat", null)

func _on_metal_hat_button_pressed():
	$CanvasLayer/Panels/HatPanel/TextureRect.texture = $CanvasLayer/GridMenus/HatsMenu/HatsGrid/MetalHatButton.icon
	$CanvasLayer/Flippables/Hat.texture = $CanvasLayer/Panels/HatPanel/TextureRect.texture
	$CanvasLayer/Panels/HatPanel/HatCheckButton.disabled = false
	current_hat = "MetalHat"
	emit_signal("equipment_change", "Hat", null)

# Weapons
func _on_none_weapon_pressed():
	$CanvasLayer/Panels/WeaponPanel/WeaponCheckButton.button_pressed = true
	$CanvasLayer/Panels/WeaponPanel/WeaponCheckButton.disabled = true
	$CanvasLayer/Panels/WeaponPanel/TextureRect.texture = null
	$CanvasLayer/Flippables/Weapon.texture = null
	current_weapon = null
	emit_signal("equipment_change", "Weapon", null)

func _on_wood_sword_pressed():
	$CanvasLayer/Panels/WeaponPanel/TextureRect.texture = $CanvasLayer/GridMenus/WeaponsMenu/WeaponsGrid/WoodSwordButton.icon
	$CanvasLayer/Flippables/Weapon.texture = $CanvasLayer/Panels/WeaponPanel/TextureRect.texture
	$CanvasLayer/Panels/WeaponPanel/WeaponCheckButton.disabled = false
	current_weapon = "WoodSword"
	emit_signal("equipment_change", "Weapon", null)

func _on_metal_sword_button_pressed():
	$CanvasLayer/Panels/WeaponPanel/TextureRect.texture = $CanvasLayer/GridMenus/WeaponsMenu/WeaponsGrid/MetalSwordButton.icon
	$CanvasLayer/Flippables/Weapon.texture = $CanvasLayer/Panels/WeaponPanel/TextureRect.texture
	$CanvasLayer/Panels/WeaponPanel/WeaponCheckButton.disabled = false
	current_weapon = "MetalSword"
	emit_signal("equipment_change", "Weapon", null)


# Visibility Buttons
func _on_shoes_check_button_toggled(toggled_on):
	$CanvasLayer/Flippables/LBoot.visible = toggled_on
	$CanvasLayer/Flippables/RBoot.visible = toggled_on
	$CanvasLayer/Flippables/LeftFoot.visible = not toggled_on
	$CanvasLayer/Flippables/RightFoot.visible = not toggled_on
	emit_signal("equipment_visibility_changed", "Shoe", toggled_on)

func _on_hat_check_button_toggled(toggled_on):
	$CanvasLayer/Flippables/Hat.visible = toggled_on
	emit_signal("equipment_visibility_changed", "Hat", toggled_on)

func _on_garment_check_button_toggled(toggled_on):
	$CanvasLayer/Flippables/Garment.visible = toggled_on
	emit_signal("equipment_visibility_changed", "Garment", toggled_on)

func _on_weapon_check_button_toggled(toggled_on):
	$CanvasLayer/Flippables/Weapon.visible = toggled_on
	emit_signal("equipment_visibility_changed", "Weapon", toggled_on)

