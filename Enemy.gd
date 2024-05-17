extends CharacterBody2D

@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var ray_cast_2d_right = $RayCast2DRight

var direction = 1
var SPEED = 50

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon

func _physics_process(delta):
	movement()
	move_and_slide()

func movement():
	if ray_cast_2d_right.is_colliding():
		direction *= -1
		scale.x *= -1
	velocity.x = direction * SPEED