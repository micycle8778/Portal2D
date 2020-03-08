extends MarginContainer

const save_file = 'user://save.json'

func _on_Quit_pressed():
	get_tree().quit()

func _on_Main_Menu_pressed():
	get_tree().change_scene("res://UIs/MainMenu.tscn")

func _on_Play_pressed():
	if File.new().file_exists(save_file): 
		var file = File.new()
		file.open(save_file, File.READ)
		var data = parse_json(file.get_as_text())
		get_tree().change_scene('res://Worlds/world'+str(data['world_num'])+'.tscn')
