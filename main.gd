extends Node2D

func _physics_process(delta):
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		get_tree().paused = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		get_tree().paused = false

func _on_finish__body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if $player == null:
		return
	
	var pause_menu = $player/PauseMenu
	var fin_node = $player/fin_
	
	if pause_menu != null:
		pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	get_tree().paused = true
	
	if fin_node != null:
		fin_node.process_mode = Node.PROCESS_MODE_ALWAYS
