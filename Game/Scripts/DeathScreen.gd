extends MarginContainer

const save_file = 'user://save.json'

func _on_Quit_pressed():
	get_tree().quit()

func _on_Main_Menu_pressed():
	get_tree().change_scene("res://UIs/MainMenu.tscn")

func _on_Play_pressed():
	PlayerVars.reset()
	get_tree().change_scene('res://Worlds/World'+str(PlayerVars.last_world)+'.tscn')
		
