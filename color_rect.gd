extends ColorRect

@export var fade_time: float = 10.0 
var elapsed_time: float = 0.0

func _ready():
	self.visible = true
	color.a = 0.0

func _process(delta):
	if elapsed_time < fade_time:
		elapsed_time += delta
		var t = clamp(elapsed_time / fade_time, 0.0, 1.0)
		color.a = t
