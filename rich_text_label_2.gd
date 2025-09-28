extends RichTextLabel

@export var trigger_x: float = -58000
@export var fade_distance: float = 2000.0
@onready var player = get_node_or_null("/root/main/player")

func _ready():
	modulate.a = 0.0

func _process(delta):
	if not player:
		return
	
	var distance = trigger_x - player.global_position.x
	
	
	if distance <= 0:
		modulate.a = 0.0
	elif distance >= fade_distance:
		modulate.a = 1.0
	else:
		modulate.a = distance / fade_distance
