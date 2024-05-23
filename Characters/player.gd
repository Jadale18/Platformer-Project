extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1500.0
const FRICTION = 800.0
const DASHSPEED = 500.0
const WALLJUMPHEIGHT = -250
const WALLJUMPDISTANCE = 350

var coyote_time = false
var jump_buffer = false
const jump_reduction = 1.8
var jumping = false
var falling = false
var double_used = false

var dashing = false
var dashable = false
var moving = true
var dashbuffer = false

var facing = 1


@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var starting_pos = global_position

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	match_polygon()

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_wall_jump()
	check_falling()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_axis(direction, delta)
	handle_anims()
	dash(direction)
	
	move_and_slide()

func handle_anims():
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("Rest")
	elif not jumping and not falling:
		$AnimatedSprite2D.play("Run")
	elif jumping and not falling:
		$AnimatedSprite2D.play('Jump')
	elif falling:
		$AnimatedSprite2D.play('fall')

	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		facing = -1
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		facing = 1

# Movement
func handle_axis(direction, delta):
	if direction and moving:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	elif moving:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func handle_jump():
	if is_on_floor():
		jumping = false
		double_used = false
		coyote_time = true
		$Coyote.start()
		if jump_buffer:
			double_used = false
			jump()
	elif jump_buffer and not double_used and Inventory.double_jump and dashbuffer:
		moving = true
		jump()
		double_used = true
	if Input.is_action_just_pressed("ui_up"):
		if (is_on_floor() or coyote_time) and not jumping and not dashing:
			jump()
			coyote_time = false
		elif not double_used and Inventory.double_jump and not dashing:
			jump()
			coyote_time = false
			double_used = true
		else:
			$JumpBuffer.start()
			jump_buffer = true
	if Input.is_action_just_released("ui_up") and velocity.y < 0:
		velocity.y = velocity.y/jump_reduction

func jump():
	if moving:
		jumping = true
		velocity.y = JUMP_VELOCITY

func handle_wall_jump():
	if is_on_wall_only() and Input.is_action_just_pressed('ui_up') and Inventory.wall_jump:
		velocity.y = WALLJUMPHEIGHT
		velocity.x = WALLJUMPDISTANCE * -facing
		double_used = false
		dashable = true

func check_falling():
	if velocity.y > 0:
		falling = true
	else:
		falling = false

func apply_gravity(delta):
	if not is_on_floor() and moving:
		velocity.y += gravity * delta

func dash(direction):
	if is_on_floor():
		dashable = true
	if dashing:
		moving = false
	else:
		moving = true
	if Input.is_action_just_pressed("Dash") and Inventory.dash == true and not dashing and dashable and not dashbuffer:
		$DashTimer.start()
		dashing = true
		dashable = false
		velocity.y = 0
		velocity.x = facing * DASHSPEED

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
	elif area.get_parent().is_in_group("Items"):
		area.get_parent().reparent(Inventory.get_child(0))
	else:
		get_tree().root.add_child(Global.battle_scene)
		Global.player_pos = global_position
		Global.spawn_enemies = false
		get_node("/root/World").queue_free()

func _on_dash_timer_timeout():
	dashbuffer = true
	dashing = false
	velocity.x = SPEED * facing
	$DashBuffer.start()

func _on_dash_buffer_timeout():
	dashbuffer = false
