extends KinematicBody2D

signal shoot(direction, exit_position, type)
signal player_dead

const UP = Vector2(0, -1)
const ACCELERATION = 50
const MAX_SPEED = 235
const JUMP_HEIGHT = 450
const type = 'player'

export(float) var shoot_time = 1
export(int) var GRAVITY = 20
export(bool) var lifebar_visible = true

var portal_des = 2
var call_track = 0
var motion = Vector2()
var can_shoot = [true,true]

func _ready():	
	if lifebar_visible:
		$"LifeContainer/Lifebar".max_value = PlayerVars.max_health
		$"LifeContainer/Lifebar".value = PlayerVars.health
	else:
		$LifeContainer.visible = false
	get_parent().connect('hurt_player', self, '_on_hurt_player')

func _on_hurt_player(dmg):
	PlayerVars.health -= dmg
	$"LifeContainer/Lifebar".value = PlayerVars.health
	if PlayerVars.health <= 0: emit_signal('player_dead')

func _input(event):
	if Input.is_action_just_pressed('fire0') and can_shoot[0]:
		emit_signal('shoot', $Cannon.global_rotation, $"Cannon/FirePos".global_position, 0)
		can_shoot[0] = false
		$ShootTimer0.start(shoot_time)
	elif Input.is_action_just_pressed('fire1') and can_shoot[1]:
		emit_signal('shoot', $Cannon.global_rotation, $"Cannon/FirePos".global_position, 1)
		can_shoot[1] = false
		$ShootTimer1.start(shoot_time)

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	$Cannon.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed('ui_right'):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed('ui_left'):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
	else:
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed('ui_up'):
			motion.y = -JUMP_HEIGHT
		if friction: motion.x = lerp(motion.x, 0, 0.2)
	else:
		if friction: motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)

func _on_ShootTimer0_timeout():
	can_shoot[0] = true


func _on_ShootTimer1_timeout():
	can_shoot[1] = true
