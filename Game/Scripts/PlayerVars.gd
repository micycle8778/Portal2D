extends Node

const max_health = 100
var health
var last_world = 0

func reset():
	health = max_health

func _ready():
	reset()
