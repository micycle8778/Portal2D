extends "res://Scripts/World.gd"

func _ready():
	PlayerVars.health = PlayerVars.max_health
	$Player/LifeContainer/Lifebar.value = PlayerVars.health
	._ready()
	
