extends Node2D

func _ready():
	var file = File.new()
	file.open('user://save.json', File.WRITE)
	file.store_string(to_json({'world_num':0,'last_world':0}))
	
