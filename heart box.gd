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
	if organ == "Heart":
		await get_tree().create_timer(3.0).timeout
		$Sprite2D.visible = false


	

func _physics_process(delta):


	if Input.is_action_just_pressed("interact") == true and isinsidearea == true:
		Signals.organpickup.emit("Heart")
		Signals.organanim.emit()
		organfinished = true
		await get_tree().create_timer(3.0).timeout
		$firstlabel.clear()
		$firstlabel.append_text("[center]Press [color=red]Shift[/color] to Dash")
		await get_tree().create_timer(10.0).timeout
		$firstlabel.clear()
		
