extends Area2D
var hasseendetails = false
var organfinished = false
var isinsidearea = false
var livered = false
func _on_body_entered(body):
	if body is CharacterBody2D:
		$firstlabel.visible = true
		isinsidearea = true



func _on_body_exited(body):
	if body is CharacterBody2D:
		isinsidearea = false
		if organfinished == false:
			$firstlabel.visible = false


func _ready():
	Signals.organpickup.connect(setorgan)
	
func setorgan(organ):
	if organ == "Liver":
		await get_tree().create_timer(3.0).timeout
		$Sprite2D.visible = false
		livered = true

	

func _physics_process(delta):
	if $firstlabel.visible == true and Input.is_action_just_pressed("interact") and hasseendetails == false:
		$firstlabel.clear()
		hasseendetails = true
		$firstlabel.append_text("[center]Replaces: [color=red]Liver[/color]\nGrants: [color=lime]Running Speed[/color]\n[center]Press [color=red]E[/color] to Confirm")
		await get_tree().create_timer(1.0).timeout
	if Input.is_action_just_pressed("interact") and hasseendetails == true and isinsidearea == true and livered == false:
		Signals.organpickup.emit("Liver")
		Signals.organanim.emit()
		$firstlabel.clear()
		organfinished = true
