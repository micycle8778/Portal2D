extends Area2D

signal detected_player(position)

var velocity = Vector2()


func _physics_process(delta):
	position += Vector2(velocity.x*delta, velocity.y*delta)

func _on_Scanner_body_entered(body):
	#if body.type == "player": emit_signal("detected_player", global_position)
	queue_free()
