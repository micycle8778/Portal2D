extends Area2D

const type = 'goal'
var exit_scene

func string_to_arr(s):
	var arr = []
	for c in s:
		arr.append(c)
	return arr

func arr_to_string(arr):
	var string = ''
	for s in arr:
		string += s
	return string

func string_slice(string, start, end, step=1):
	return arr_to_string(string_to_arr(string).slice(start, end, step))

func _ready():
	filename = get_parent().filename
	if filename:
		var world_num = str(int(filename[18])+1)
		
		var next_scene = 'res://Worlds/World'+world_num+'.tscn'
		if File.new().file_exists('res://Worlds/World'+world_num+'.tscn'):
			exit_scene = next_scene
		else:
			exit_scene = 'res://Worlds/World0.tscn'
		

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.name == 'Player':
			get_tree().change_scene(exit_scene)
