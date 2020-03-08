extends Area2D
#No fortnite here

signal kill_player

export(bool) var sprite_visible = false

const type = 'killzone'

func _ready():
	$Sprite.visible = sprite_visible

func _on_Killzone_body_entered(body):
	if body.type == 'player': emit_signal('kill_player')
