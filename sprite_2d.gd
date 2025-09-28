extends Sprite2D

@export var float_height: float = 35.0
@export var float_speed: float = 1

var base_offset_y: float
var bobbing: float = 0.0

func _ready():
	base_offset_y = position.y  

func _physics_process(delta):
	if Input.is_action_pressed("left") and not get_parent().velocity == Vector2(0, 0):
		flip_h = false
	elif Input.is_action_pressed("right") and not get_parent().velocity == Vector2(0, 0):
		flip_h = true

	bobbing += delta * float_speed


	if get_parent().is_on_floor():
		position.y = base_offset_y + sin(bobbing) * float_height
	else:
		position.y = base_offset_y
