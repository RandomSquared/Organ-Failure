extends Camera2D

@onready var player = get_parent().velocity

@export var look_ahead_factor: float = 0.4

@export var smooth_speed: float = 3.0
@export var idle_drop_distance: float = 200.0  

func _ready():
	Signals.organanim.connect(animation)
	Signals.organpickup.connect(blindnessVI)

func animation():
	await get_tree().create_timer(1).timeout


	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "zoom", Vector2(0.4, 0.4), 1)
	tween.tween_property(self, "zoom", Vector2(0.5, 0.5), 0.2)

	# shake 1
	var shake1 = get_tree().create_tween().bind_node(self)
	shake1.set_loops(10)
	shake1.set_parallel(true)
	shake1.tween_property(self, "offset", Vector2(20, 0), 0.05)
	shake1.tween_property(self, "offset", Vector2(-20, 0), 0.1)
	shake1.tween_property(self, "offset", Vector2(0, 0), 0.05)

	# shake 2
	await get_tree().create_timer(1).timeout
	var shake2 = get_tree().create_tween().bind_node(self)
	shake2.set_loops(5) 
	shake2.set_parallel(true)
	shake2.tween_property(self, "offset", Vector2(50, 0), 0.05)
	shake2.tween_property(self, "offset", Vector2(-50, 0), 0.1)
	shake2.tween_property(self, "offset", Vector2(0, 0), 0.05)

func blindnessVI(organ):
	if organ == "Eye":
		$eyepenalty.visible = true
		$eyepenalty2a.visible = true

func _process(delta):
	var parent = get_parent()

	var target_offset = Vector2.ZERO
	if abs(parent.velocity.x) > 0:
		target_offset.x = parent.velocity.x * look_ahead_factor
		target_offset.y = 0.0
	else:
		target_offset.x = 0.0
		target_offset.y = idle_drop_distance

	self.position = self.position.lerp(target_offset, smooth_speed * delta)
