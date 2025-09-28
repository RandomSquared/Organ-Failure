extends Area2D
var organfinished = false
var isinsidearea = false

func _on_body_entered(body):
	if body is CharacterBody2D:
		isinsidearea = true


func _on_body_exited(body):
	if body is CharacterBody2D:
		isinsidearea = false

func _ready():
	Signals.organpickup.connect(setorgan)
	
func setorgan(organ):
	if organ == "Lungs":
		await get_tree().create_timer(3.0).timeout
		$Sprite2D.visible = false


	

func _physics_process(delta):


	if Input.is_action_just_pressed("interact") == true and isinsidearea == true and organfinished == false:
		Signals.organpickup.emit("Lungs")
		Signals.organanim.emit()
		organfinished = true



		
