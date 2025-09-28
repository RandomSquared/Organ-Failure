extends ColorRect
var animating = false

func _physics_process(delta):
	if get_tree().paused == false and animating == false:
		self.visible = false
	elif get_tree().paused == true and animating == false:
		self.visible = true

func _ready():
	Signals.organpickup.connect(setorgan)
	Signals.organanim.connect(middleanim)
	
func setorgan(organ):
	if organ == "Liver":
		$liver.visible = false
		$metal_liver.visible = true
	if organ == "Heart":
		$heart.visible = false
		$metal_heart.visible = true
	if organ == "Lungs":
		$lungs.visible = false
		$metal_lungs.visible = true
	if organ == "Eye":
		$eye.visible = false
		$metal_eye.visible = true

func middleanim():
	animating = true
	await get_tree().create_timer(3).timeout
	animating = false
