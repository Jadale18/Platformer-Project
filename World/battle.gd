extends Node2D

@onready var global = Global
@onready var player_health = global.player_health
var enemy_health = 10
var state = 'player_turn'

func _ready():
	pass


func _process(delta):
	$PlayerHealth.value = player_health
	$EnemyHealth.value = enemy_health


func _on_scram_pressed():
	get_tree().root.add_child(Global.world_scene)
	get_node("/root/Battle").queue_free()
	Global.battle_scene = preload('res://World/battle.tscn').instantiate()
	Global.world_scene = preload('res://World/world.tscn').instantiate()
