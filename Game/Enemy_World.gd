extends "res://World.gd"

signal enemy_detected(position)
signal shoot_player
signal hurt_player

export(PackedScene) var Scanner
export(PackedScene) var Enemy_Bullet
export(int) var enemy_bullet_speed = 750
export(int) var scanner_speed = 1000
export(int) var enemy_bullet_damage = 10

var enemies = []

func _ready():
	type = 'hostile'
	for node in get_children():
		if not node.get_class() == 'RigidBody2D': continue
		if not node.type == 'enemy': continue
		enemies.append(node)
		node.connect('request_scan', self, "_on_Enemy_request_scan")
		node.connect('shoot_player', self, "_on_Enemy_shoot_player")
	$Player.connect('player_dead', self, '_on_Player_player_dead')

func _process(delta):
	emit_signal('enemy_detected', $Player.global_position)

func _on_Player_player_dead():
	restart()

func _on_Enemy_request_scan(direction, position):
	var scanner = Scanner.instance()
	scanner.position = position
	scanner.rotation = direction
	scanner.velocity = Vector2(-scanner_speed, 0).rotated(direction)
	scanner.connect('body_entered', self, "_on_Scanner_body_entered")
	
	add_child(scanner)

func _on_Scanner_body_entered(body):
	if body.type == 'player': emit_signal('shoot_player')

func _on_Enemy_shoot_player(direction, position):
	var bullet = Enemy_Bullet.instance()
	bullet.position = position
	bullet.rotation = direction
	bullet.velocity = Vector2(-enemy_bullet_speed, 0).rotated(direction)
	bullet.connect('body_entered', self, '_on_Enemy_Bullet_body_entered')
	
	add_child(bullet)

func _on_Enemy_Bullet_body_entered(body):
	if body.type == 'player': emit_signal('hurt_player', enemy_bullet_damage)

"""
func _on_Player_shoot(direction, exit_position, type):
	var bullet = Bullet.instance()
	bullet.position = exit_position
	bullet.rotation = direction
	bullet.velocity = Vector2(bullet_speed, 0).rotated(direction)
	bullet.type = type
	bullet.modulate = colors[type]
	bullet.connect('make_portal', self, '_on_PortalBullet_make_portal')
"""
