extends RigidBody2D

signal request_scan(direction, exit_position)
signal shoot_player(direction, exit_position)

const type = 'enemy'

var can_aim = true
var can_shoot = true
var portal_des = 2
var call_track = 0

func _ready():
	get_parent().connect('enemy_detected', self, '_on_enemy_detected')
	get_parent().connect('shoot_player', self, '_on_shoot_player')

func _process(_delta):
	emit_signal('request_scan', $Turret.global_rotation, $"Turret/Fire Pos".global_position)

func _on_enemy_detected(position):
	#position should be a global position
	$Turret.look_at(position)
	$Turret.rotation_degrees -= 180
func _on_shoot_player():
	if can_shoot:
		can_shoot = false
		$"Firing Timer".start()
		emit_signal("shoot_player", $Turret.global_rotation, $"Turret/Fire Pos".global_position)


func _on_Firing_Timer_timeout():
	can_shoot = true
