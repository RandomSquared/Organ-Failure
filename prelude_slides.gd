extends Node2D
var onwhichslide = 1

	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("right") and onwhichslide == 1:
		$Slide1.visible = false
		$Slide2.visible = true
		await get_tree().create_timer(0.1).timeout
		onwhichslide += 1
	if Input.is_action_just_pressed("right") and onwhichslide == 2:
		$Slide2.visible = false
		$Slide3.visible = true
		await get_tree().create_timer(0.1).timeout
		onwhichslide += 1
	if Input.is_action_just_pressed("right") and onwhichslide == 3:
		$Slide3.visible = false
		get_tree().change_scene_to_file("res://game.tscn")
