extends TextureRect

signal unpause

func _on_Continue_pressed():
	emit_signal("unpause")
#	get_tree().paused = false
#	get_parent().visible = false

func _on_Level_Select_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://UIs/Level Selector.tscn")

func _on_Main_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://UIs/MainMenu.tscn")

func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().quit()
