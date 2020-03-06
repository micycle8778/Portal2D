extends Area2D

var velocity = Vector2()

func _physics_process(delta):
	position += Vector2(velocity.x*delta, velocity.y*delta)

func _on_Enemy_Bullet_body_entered(body):
	queue_free()
