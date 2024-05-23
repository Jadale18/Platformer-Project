extends Node

func _ready():
	Inventory.equipment_change.connect(_on_equipment_change)

func _on_equipment_change(type):
	if type == "Shoe":
		apply_shoe_buff()
	elif type == "Garment":
		apply_garment_buff()
	elif type == "Hat":
		apply_hat_buff()
	elif type == "Weapon":
		apply_weapon_buff()

func apply_shoe_buff():
	if Inventory.current_shoe == "LeatherBoot":
		pass
	elif Inventory.current_shoe == "MetalBoot":
		pass

func apply_garment_buff():
	if Inventory.current_garment == "LeatherGarment":
		pass
	elif Inventory.current_garment == "MetalGarment":
		pass

func apply_hat_buff():
	if Inventory.current_hat == "LeatherHat":
		pass
	elif Inventory.current_hat == "MetalHat":
		pass

func apply_weapon_buff():
	if Inventory.current_weapon == "WoodSword":
		pass
	elif Inventory.current_weapon == "MetalSword":
		pass
