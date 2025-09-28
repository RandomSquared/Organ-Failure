extends CharacterBody2D


@export var dash_speed = 5000.0
@export var dash_time = 0.2
@export var dash_cooldown = 2.0
@export var dash_upward_boost = -750.0
@export var startmefar = false

var dashing = false
var dash_timer = 0.1
var dash_cooldown_timer = 0.1

@export var gravitymult = 3
@export var jump_power = 1.65
@export var acceleration = 5
var speed = 0
var speedmult = 1
var jumpmult = 1
var savedspeed = Vector2(0, 0)
var animating = false
var doneliver = false
var dashenabled = false
var doneheart = false
var donelungs = false

# organ stuff below
func _ready():
	Signals.organpickup.connect(setorgan)
	Signals.organanim.connect(animation)
	if startmefar == true:
		position = Vector2(-60000, -1000)

func setorgan(organ):
		if organ == "Liver" and doneliver == false:
			speedmult += 0.5
			doneliver = true
		if organ == "Heart" and doneheart == false:
			dashenabled = true
			doneheart = true
			speedmult -= 0.4
			jumpmult -= 0.2
		if organ == "Lungs" and donelungs == false:
			donelungs = true
			speedmult -= 0.4
			jumpmult += 0.5
			

func animation():
	animating = true
	$Sprite2D.visible = false
	$frame1.visible = true
	await get_tree().create_timer(1).timeout
	$blood.emitting = true
	$frame1.visible = false
	$frame2.visible = true
	$rip.play(0.5)
	await get_tree().create_timer(0.3).timeout
	$rip.stop()
	await get_tree().create_timer(0.7).timeout
	$frame2.visible = false
	$frame3.visible = true
	$crush.emitting = true
	$crush_sfx.play(0.2)
	await get_tree().create_timer(1).timeout
	$crush_sfx.stop()
	$frame3.visible = false
	$Sprite2D.visible = true
	$blood.emitting = false
	$crush.emitting = false
	animating = false
	
	
	
	
#movement
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravitymult

func _physics_process(delta):

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta


	if not is_on_floor() and not dashing:
		velocity.y += gravity * delta
	
	# jump
	if Input.is_action_pressed("jump") and is_on_floor() and not dashing:
		velocity.y = jump_power * -1000 * jumpmult
		
		
	if dashenabled and not dashing and dash_cooldown_timer <= 0.0 and Input.is_action_just_pressed("dash"):
		dashing = true
		dash_timer = dash_time
		dash_cooldown_timer = dash_cooldown
		if Input.is_action_pressed("right"):
			velocity = Vector2(dash_speed, dash_upward_boost)
		elif Input.is_action_pressed("left"):
			velocity = Vector2(-dash_speed, dash_upward_boost)
		else:
			velocity = Vector2(sign(velocity.x) * dash_speed, dash_upward_boost)
	
	if dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			dashing = false
	else:
		if is_on_wall():
			speed = 0
		elif Input.is_action_pressed("right") and is_on_floor():
			speed += acceleration * delta * speedmult
		elif Input.is_action_pressed("left") and is_on_floor():
			speed += acceleration * delta * -1 * speedmult
		if not Input.is_anything_pressed() and is_on_floor():
			speed = 0
		if Input.is_action_pressed("left") and is_on_floor() and speed > 0:
			speed = 0
		if Input.is_action_pressed("right") and is_on_floor() and speed < 0:
			speed = 0
		
		if speed > 1.3 * speedmult:
			speed = 1.3 * speedmult
		if speed < -1.3 * speedmult:
			speed = -1.3 * speedmult
		velocity.x = speed * 1000
		

	if position.y > 1000:
		velocity = Vector2(0, 0)
		$Death.visible = true
		$deathmsg.visible = true
	
	if Input.is_action_just_pressed("restart") and $Death.visible == true:
		$Death.visible = false
		$deathmsg.visible = false
		if global_position.x > -7500:
			global_position = Vector2(0,0)
		if global_position.x < -7500 and global_position.x > -17000:
			global_position = Vector2(-7500,0)
		if global_position.x < -17000 and global_position.x > -31000:
			global_position = Vector2(-17000,-700)
		if global_position.x < -31000 and global_position.x > -45000:
			global_position = Vector2(-31000,0)
		if global_position.x < -45000:
			global_position = Vector2(-45000,-1000)
		velocity = Vector2(0,0)
	
	if animating == true:
		velocity = Vector2(0, 0)
	
	move_and_slide()
