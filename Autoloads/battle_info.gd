extends Node2D

var current_enemy: String
var enemy_health: int
var enemy_defense: float

# Format [Health, defense]
var healths_dict = {'Enemy': [10, 1]}

func set_values():
	enemy_health = healths_dict[current_enemy][0]
	enemy_defense = healths_dict[current_enemy][1]


func enemy_attacks():
	var choice = randi_range(1,2)
	if choice == 1:
		return ["Full Attack",15, null]
	if choice == 2:
		return ["Attack and Defend", 5, 'Defend']
