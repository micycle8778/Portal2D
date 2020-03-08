extends MarginContainer




func _on_PLAY_pressed():
	get_tree().change_scene("res://Worlds/World0.tscn")


func _on_Leave_pressed():
	get_tree().quit()
