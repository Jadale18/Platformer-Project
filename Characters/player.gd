extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1500.0
const FRICTION = 800.0
var coyote_time = false
var jump_buffer = false
const jump_reduction = 1.8

@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var starting_pos = global_position

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	match_polygon()

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_axis(direction, delta)
	handle_anims()
	
	move_and_slide()

func handle_anims():
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("Rest")
	else:
		$AnimatedSprite2D.play("Run")
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

#Movement
func handle_axis(direction, delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func handle_jump():
	if is_on_floor():
		coyote_time = true
		$Coyote.start()
		if jump_buffer:
			velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor() or coyote_time:
			velocity.y = JUMP_VELOCITY
			coyote_time = false
		else:
			$JumpBuffer.start()
			jump_buffer = true
	if Input.is_action_just_released("ui_up") and velocity.y < 0:
		velocity.y = velocity.y/jump_reduction

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func match_polygon():
	polygon_2d.polygon = collision_polygon_2d.polygon

#Signals
func _on_coyote_timeout():
	coyote_time = false

func _on_jump_buffer_timeout():
	jump_buffer = false

func _on_area_2d_area_entered(area):
	if area.name == "Hazards":
		global_position = starting_pos
	elif area.name == 'Cutscene':
		pass
	else:
		get_tree().root.add_child(Global.battle_scene)
		Global.player_pos = global_position
		Global.spawn_enemies = false
		get_node("/root/World").queue_free()
		
