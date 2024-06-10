extends CharacterBody2D

@onready var ray_cast = $RayCast2D

var direction = 1
var SPEED = 50
var health = 10
var in_battle = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimationPlayer.play('Walk')

func _physics_process(delta):
	if not in_battle:
		movement()
		apply_gravity(delta)
		move_and_slide()
	else:
		$AnimationPlayer.play('Idle')
		scale = Vector2(-0.15,-0.15)
		position = Vector2(900,190)

func movement():
	if ray_cast.is_colliding():
		direction *= -1
		scale.x *= -1
	velocity.x = direction * SPEED

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
