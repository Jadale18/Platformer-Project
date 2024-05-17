extends Node2D

var player_health = 100
var enemy_health = 10
var state = 'player_turn'

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayerHealth.value = player_health
	$EnemyHealth.value = enemy_health
