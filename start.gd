extends Sprite2D


func _on_start_2_mouse_entered() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "scale", Vector2(2,2), 0.2)
	
func _on_start_2_mouse_exited() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.2)
