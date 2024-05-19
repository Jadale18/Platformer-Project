extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
var enemy_scene = preload('res://Characters/enemy.tscn').instantiate()


func _ready():
	RenderingServer.set_default_clear_color(Color8(73,151,206,1))
	polygon_2d.polygon = collision_polygon_2d.polygon
	$StaticBody2D2/CollisionPolygon2D/Polygon2D.polygon = $StaticBody2D2/CollisionPolygon2D.polygon
	$Player.global_position = Global.player_pos
	
	if Global.spawn_enemies:
		enemy_scene.position = Vector2(744,512)
		add_child(enemy_scene)


func _on_cutscene_area_entered(area):
	$CanvasLayer.show()
	$AnimationPlayer.play("Cutscene")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cutscene":
		$CanvasLayer.hide()
