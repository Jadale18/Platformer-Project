extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1500.0
const FRICTION = 800.0
const DASHSPEED = 350.0
const WALLJUMPHEIGHT = -250
const WALLJUMPDISTANCE = 350

var coyote_time = false
var jump_buffer = false
const jump_reduction = 1.8
var jumping = false
var falling = false
var double_used = false
var on_ground = false

var dashing = false
var dashable = false
var moving = true
var dashbuffer = false

var attacking = false
var facing = 1

var lshoe = preload('res://Assets/Player/Char_Legs-1.png')
var rshoe = preload('res://Assets/Player/Char_Legs-2.png')
var jump_particles = preload('res://Particles/jump_particles.tscn').instantiate()

@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $CollisionPolygon2D/Polygon2D
@onready var starting_pos = global_position

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Inventory.equipment_change.connect(_on_equipment_change)
	Inventory.equipment_visibility_changed.connect(_on_equipment_visibility_changed)
	match_polygon()
	$Flippables/LeftFoot.position = Vector2(4.428, 10.239)
	$Flippables/RightFoot.position = Vector2(-4.428, 10.477)
	$Flippables/LeftFoot.rotation = 0
	$Flippables/RightFoot.rotation = 0

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_wall_jump()
	check_falling()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_axis(direction, delta)
	handle_attack()
	handle_anims()
	dash()
	handle_landing()
	
	move_and_slide()

func handle_anims():
	if attacking and not dashing:
		$Flippables/AttackAnim.play('attack')
	if dashing:
		$Flippables/AnimatedSprite2D.play("Dash")
		$Flippables/AnimationPlayer.play("Dash")
	elif velocity.x == 0 and is_on_floor():
		$Flippables/AnimatedSprite2D.play("Rest")
		$Flippables/AnimationPlayer.play("Rest")
	elif not jumping and not falling:
		$Flippables/AnimatedSprite2D.play("Run")
		$Flippables/AnimationPlayer.play("Walk")
	elif jumping and not falling:
		$Flippables/AnimatedSprite2D.play('Jump')
		$Flippables/AnimationPlayer.play("Jump")
	elif falling and $Flippables/AnimatedSprite2D.animation != 'falling':
		$Flippables/AnimatedSprite2D.play('fall')
		$Flippables/AnimationPlayer.play("about_to_fall")
	
	if velocity.x < 0:
		facing = -1
		$Flippables.scale.x = -1
	if velocity.x > 0:
		facing = 1
		$Flippables.scale.x = 1

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
		jump
		jump_particles.rotation = velocity.x / 300
		add_child(jump_particles)
		jump_particles = preload('res://Particles/jump_particles.tscn').instantiate()
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

func dash():
	if is_on_floor():
		dashable = true
	if dashing:
		moving = false
	else:
		moving = true
	if Input.is_action_just_pressed("Dash") and Inventory.dash == true and not dashing and dashable and not dashbuffer:
		$DashTimer.start()
		$Flippables/AnimatedSprite2D.speed_scale = 2.5
		$Flippables/DashParticles.emitting = true
		dashing = true
		dashable = false
		velocity.y = 0
		velocity.x = facing * DASHSPEED
	if $Flippables/DashParticles.emitting and is_on_wall():
		$Flippables/DashParticles.emitting = false

func match_polygon():
	polygon_2d.polygon = collision_polygon_2d.polygon

func handle_attack():
	if Input.is_action_just_pressed("attack") and not attacking:
		attacking = true
		$AttackBuffer.start()

func handle_landing():
	if is_on_floor():
		if not on_ground:
			$LandParticles.emitting = true
			$LandParticles2.emitting = true
		on_ground = true
	else:
		on_ground = false

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
		BattleInfo.current_enemy = area.get_parent().name
		area.get_parent().in_battle = true
		area.get_parent().reparent(BattleInfo)
		BattleInfo.set_values()
		get_tree().root.add_child(Global.battle_scene)
		Global.player_pos = global_position
		Global.spawn_enemies = false
		get_node("/root/World").queue_free()

func _on_dash_timer_timeout():
	$Flippables/DashParticles.emitting = false
	dashbuffer = true
	dashing = false
	velocity.x = SPEED * facing
	$DashBuffer.start()
	$Flippables/AnimatedSprite2D.speed_scale = 1

func _on_dash_buffer_timeout():
	dashbuffer = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'about_to_fall':
		$Flippables/AnimatedSprite2D.play("falling")
		$Flippables/AnimationPlayer.play("Fall")

func _on_attack_buffer_timeout():
	attacking = false
	$Flippables/AttackAnim.stop()

func _on_equipment_change(type, vible):
	if type == "Shoe":
		if vible:
			$Flippables/LeftFoot.texture = Inventory.get_child(1).get_child(1).get_child(8).texture
			$Flippables/RightFoot.texture = Inventory.get_child(1).get_child(1).get_child(9).texture
		if not Inventory.current_shoe:
			$Flippables/LeftFoot.texture = lshoe
			$Flippables/RightFoot.texture = rshoe
	elif type == "Garment":
		$Flippables/Garment.texture = Inventory.get_child(1).get_child(2).get_child(2).get_child(0).texture
		if not Inventory.current_garment:
			$Flippables/Garment.texture = null
	elif type == "Hat":
		$Flippables/Hat.texture = Inventory.get_child(1).get_child(2).get_child(1).get_child(0).texture
		if not Inventory.current_hat:
			$Flippables/Hat.texture = null
	elif type == "Weapon":
		$Flippables/Weapon.texture = Inventory.get_child(1).get_child(2).get_child(3).get_child(0).texture
		if not Inventory.current_weapon:
			$Flippables/Weapon.texture = null

func _on_equipment_visibility_changed(type, vible):
	if type == "Shoe":
		if vible:
			$Flippables/LeftFoot.texture = Inventory.get_child(1).get_child(1).get_child(8).texture
			$Flippables/RightFoot.texture = Inventory.get_child(1).get_child(1).get_child(9).texture
		else:
			$Flippables/LeftFoot.texture = lshoe
			$Flippables/RightFoot.texture = rshoe
	elif type == "Garment":
		$Flippables/Garment.visible = vible
	elif type == "Hat":
		$Flippables/Hat.visible = vible
	elif type == "Weapon":
		$Flippables/Weapon.visible = vible
