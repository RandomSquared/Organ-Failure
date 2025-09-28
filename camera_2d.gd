extends Camera2D

func _ready():
	Signals.organanim.connect(animation)
	Signals.organpickup.connect(shrinkcam)

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

func shrinkcam(organ):
	if organ == "Eye":
		await get_tree().create_timer(1.0).timeout
		get_window().set_flag(Window.FLAG_RESIZE_DISABLED, false)
		DisplayServer.window_set_size(Vector2i(1080, 1080))
		get_window().set_flag(Window.FLAG_RESIZE_DISABLED, true)
		$ColorRect.visible = true
		position.x += 700
