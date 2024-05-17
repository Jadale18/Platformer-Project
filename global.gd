extends Node


var player_health = 100
var battle_scene = preload('res://World/battle.tscn').instantiate()
var world_scene = preload('res://World/world.tscn').instantiate()
var player_pos = Vector2(0,0)

var spawn_enemies = true
