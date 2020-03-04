extends Node2D

signal teleport_player(portal,type,player)

export(int) var type



func _on_Area2D_body_entered(body):
	if body.name == 'Player': emit_signal('teleport_player', self, type, body)
