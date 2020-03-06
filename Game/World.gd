extends Node2D

const offset = Vector2(32,0)

export(PackedScene) var Bullet
export(PackedScene) var Portal
export(float) var bullet_speed = 50
export(float) var teleport_delay = .5

var can_teleport = true
var type = 'peaceful'


func restart():
	get_tree().change_scene(filename)

func adjecent_tile(vert, map, pos):
	var add
	if vert: add = [Vector2(0,1), Vector2(0,-1)]
	else: add = [Vector2(1,0), Vector2(-1,0)]
	
	var return_value = false
	for offset in add:
		return_value = return_value or (map.get_cellv(pos+offset) != map.INVALID_CELL)
	
	return return_value
	

var colors = [
	Color(0,1,1), # Portal 0: cyan
	Color(1,0.3568,0.2) # Portal 1: orange
]

var portals = [null, null]

func _on_Player_shoot(direction, exit_position, type):
	var bullet = Bullet.instance()
	bullet.position = exit_position
	bullet.rotation = direction
	bullet.velocity = Vector2(bullet_speed, 0).rotated(direction)
	bullet.type = type
	bullet.modulate = colors[type]
	bullet.connect('make_portal', self, '_on_PortalBullet_make_portal')
	
	add_child(bullet)

func _on_PortalBullet_make_portal(position, type, side):
	#print('hello')
	var positions = {
		-90:[Vector2(-32,0),Vector2(0,0),Vector2(32,0)],
		90:[Vector2(-32,0),Vector2(0,0),Vector2(32,0)],
		0:[Vector2(0,-32),Vector2(0,0),Vector2(0,32)],
		180:[Vector2(0,-32),Vector2(0,0),Vector2(0,32)]
	}
	
	var tile_map = get_node('TileMap')
	
	if portals[type] == null:
		portals[type] = []
		for i in range(3):
			var portal = Portal.instance()
			portal.rotation_degrees = side
			portal.type = type
			portal.modulate = colors[type]
			portal.position = position+positions[side][i]
			portals[type].append(portal)
			var tile = tile_map.world_to_map(portal.position)
			if (adjecent_tile(true, tile_map, tile) and adjecent_tile(false, tile_map, tile)): # If this isn't a corner
				continue
			portal.connect('teleport_player', self, '_on_Portal_teleport_player')
			add_child(portal)
	else: 
		for portal in portals[type]:
			portal.queue_free()
		portals[type] = null
		_on_PortalBullet_make_portal(position, type, side)

func _on_Portal_teleport_player(portal, type, player):
	if not can_teleport: return
	var des_type = int(not bool(type))
	var des_portals = portals[des_type]
	var portal_index = portals[type].find(portal)
	if des_portals == null: return
	portal = des_portals[portal_index]
	player.position = portal.position + offset.rotated(portal.rotation)
	can_teleport = false
	$TeleportTimer.start(teleport_delay)


func _on_TeleportTimer_timeout():
	can_teleport = true
