extends Node


var player_health = 100
var player_attack = 5
var battle_scene = preload('res://World/battle.tscn').instantiate()
var world_scene = preload('res://World/world.tscn').instantiate()
var player_pos = Vector2(168,488)
var pausable = false

var spawn_enemies = true
