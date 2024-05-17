extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
var enemy_scene = preload('res://Characters/enemy.tscn').instantiate()


func _ready():
	RenderingServer.set_default_clear_color(Color.SKY_BLUE)
	polygon_2d.polygon = collision_polygon_2d.polygon
	$Player.global_position = Global.player_pos
	
	if Global.spawn_enemies:
		enemy_scene.position = Vector2(744,512)
		add_child(enemy_scene)
