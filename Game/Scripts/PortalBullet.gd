extends Area2D

signal make_portal(position, type, side)

var velocity = Vector2()
var type
export(float) var bullet_lifetime = 2

func adjecent_tile(vert, map, pos):
	var add
	if vert: add = [Vector2(0,1), Vector2(0,-1)]
	else: add = [Vector2(1,0), Vector2(-1,0)]
	
	var return_value = false
	for offset in add:
		return_value = return_value or (map.get_cellv(pos+offset) != map.INVALID_CELL)
	
	return return_value
	

func _ready():
	$Lifetime.start(bullet_lifetime)

func _physics_process(delta):
	position += Vector2(velocity.x*delta, velocity.y*delta)

func _on_Lifetime_timeout():
	queue_free()


func _on_PortalBullet_body_entered(body):
	if not body is TileMap: return
	var tile = body.world_to_map(global_position)
	var tile_pos = body.map_to_world(body.world_to_map(global_position))
	var spawn_pos = tile_pos + Vector2(16,16)
	position = Vector2(int(position.x), int(position.y))
	
	var side
	if adjecent_tile(true, body, tile) and adjecent_tile(false, body, tile):
		#If you can make portals both vertically and horizontally, don't make portal?
		queue_free()
		return
	elif adjecent_tile(true, body, tile): # Vertically adjecent
		#If the bullet is more left than the potential portal, then portal faces left
		if position.x < spawn_pos.x: side = 180
		else: side = 0 #Otherwise portal faces right
	elif adjecent_tile(false, body, tile): # Horizontally adjecent
		if position.y < spawn_pos.y: side = -90
		else: side = 90
	
	
	emit_signal('make_portal', spawn_pos, type, side)
	
	queue_free()
	
