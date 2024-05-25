extends CharacterBody2D

@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var ray_cast_2d_right = $RayCast2DRight

var direction = 1
var SPEED = 50
var in_battle = false
var health = 10

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon

func _physics_process(delta):
	if not in_battle:
		movement()
		apply_gravity(delta)
		move_and_slide()

func movement():
	if ray_cast_2d_right.is_colliding():
		direction *= -1
		scale.x *= -1
	velocity.x = direction * SPEED

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_area_2d_area_entered(area):
	pass
	#in_battle = true
	#visible = false
	#self.reparent(BattleInfo)
