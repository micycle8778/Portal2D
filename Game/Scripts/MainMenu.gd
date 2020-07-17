extends MarginContainer

func _on_PLAY_pressed():
	get_tree().change_scene("res://UIs/Level Selector.tscn")

func _on_Leave_pressed():
	get_tree().quit()

func _on_Controls_pressed():
	get_tree().change_scene("res://UIs/Controls.tscn")

func _on_Clear_Save_pressed():
	$ConfirmationDialog.popup()

func _on_ConfirmationDialog_confirmed():
	var file = File.new()
	file.open('user://save.json', File.WRITE)
	file.store_string(to_json({'world_num':0}))
