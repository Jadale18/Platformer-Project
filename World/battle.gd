extends Node2D

@onready var global = Global
@onready var player_health = global.player_health
@onready var enemy_health = BattleInfo.enemy_health
@onready var enemy_defense = BattleInfo.enemy_defense

var states = ['player_turn', 'enemy_turn']
var state = states[0]

func _ready():
	pass


func _process(delta):
	$PlayerHealth.value = player_health
	$EnemyHealth.value = enemy_health
	
	if state == 'enemy_turn':
		enemy_turn(BattleInfo.enemy_attacks())
	
	if enemy_health <= 0:
		win()
	if player_health <= 0:
		lose()


func enemy_turn(attack):
	player_health -= attack[1]
	if attack[2] == 'Defend':
		enemy_defense += 1
	state = states[0]

func win():
	print(win)
	global.player_health = player_health
	get_tree().root.add_child(Global.world_scene)
	get_node("/root/Battle").queue_free()
	Global.battle_scene = preload('res://World/battle.tscn').instantiate()
	Global.world_scene = preload('res://World/world.tscn').instantiate()

func lose():
	print(lose)
	global.player_health = 100
	get_tree().root.add_child(Global.world_scene)
	get_node("/root/Battle").queue_free()
	Global.battle_scene = preload('res://World/battle.tscn').instantiate()
	Global.world_scene = preload('res://World/world.tscn').instantiate()

func _on_scram_pressed():
	get_tree().root.add_child(Global.world_scene)
	get_node("/root/Battle").queue_free()
	Global.battle_scene = preload('res://World/battle.tscn').instantiate()
	Global.world_scene = preload('res://World/world.tscn').instantiate()

func _on_attack_pressed():
	enemy_health -= (global.player_attack - enemy_defense)
	state = states [1]

func _on_defend_pressed():
	player_health += 10
	state = states[1]
