extends MarginContainer

var levels = []
var buttons = []
var button = preload("res://UIs/Level Button.tscn")
const save_file = 'user://save.json'

func _ready():
	PlayerVars.reset()
	
	var dir = Directory.new()
	dir.open('res://Worlds/')
	dir.list_dir_begin(true)
	
	var f = dir.get_next()
	while f != '':
		levels.append(f)
		f = dir.get_next()
	dir.list_dir_end()
	
	var limit
	if File.new().file_exists(save_file): 
		var file = File.new()
		file.open(save_file, File.READ)
		var data = parse_json(file.get_as_text())
		limit = data['world_num']
	else: limit = 0
	
	for level in levels:
		var b = button.instance()
		b.text = str(len(buttons))
		buttons.append(b)
		b.connect('pressed_wrapper', self, '_on_Level_Button_pressed_wrapper')
		$VBoxContainer/GridContainer.add_child(b)
		
		if len(buttons) > limit: break

func _on_Level_Button_pressed_wrapper(id):
	get_tree().change_scene("res://Worlds/World"+id+".tscn")


func _on_Button_pressed():
	print("menu")
	get_tree().change_scene("res://UIs/MainMenu.tscn")
