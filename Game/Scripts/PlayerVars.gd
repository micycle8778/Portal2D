extends Node

const max_health = 70
var health
var last_world = 0

func reset():
	health = max_health / 2

func _ready():
	reset()
