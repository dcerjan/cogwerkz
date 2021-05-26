tool
extends Spatial
class_name HexMap

var tile = preload('res://scene/HexTile.tscn')

export(int) var map_radius = 3 setget _set_map_radius

var map_tiles = []
var tiles = {}
var tiles_by_id = {}
var last_tile_entered = null

signal tile_map_updated(tile_map)
signal tile_clicked(tile)

func _set_map_radius(new_map_radius: int) -> void:
	map_radius = new_map_radius
	map_tiles = []
	var size = 1 + 2 * map_radius
	for q in range(size):
		var row = []
		for r in range(size):
			if q < map_radius:
				if map_radius - q - r > 0:
					row.push_back(null)
				else:
					row.push_back(1)
			elif q == map_radius:
				row.push_back(1)
			else:
				if -(size + map_radius - q - r - 1) > 0:
					row.push_back(null)
				else:
					row.push_back(1)
		map_tiles.push_back(row)
	update_tiles()

func _ready() -> void:
	_set_map_radius(map_radius)
	update_tiles()

func update_tiles() -> void:
	var children = get_children()
	for c in children:
		remove_child(c)

	var q = - map_radius
	var r = - map_radius
	var id: int = 1
	tiles = {}
	tiles_by_id = {}
	for row in map_tiles:
		var tiles_row = {}
		for cell in row:
			if cell != null:
				var t = tile.instance(PackedScene.GEN_EDIT_STATE_INSTANCE)
				add_child(t)
				t.set_owner(self)
				t.id = id
				id += 1
				t.position = Vector2(q, r)
				tiles_row[q] = t
				tiles_by_id[t.id] = t
			else:
				tiles_row[q] = null
			q += 1
		tiles[r] = tiles_row
		r += 1
		q = - map_radius
	emit_signal('tile_map_updated', self)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return

	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera()

	var ray_from = camera.project_ray_origin(mouse_pos)
	var ray_to = ray_from + camera.project_ray_normal(mouse_pos) * 100.0

	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(ray_from, ray_to)

	if result.has('collider') && result.collider is HexTile:
		if last_tile_entered != result.collider:
			if last_tile_entered != null:
				last_tile_entered.on_mouse_exited()
			last_tile_entered = result.collider
			last_tile_entered.on_mouse_entered()
	else:
		if last_tile_entered != null:
			last_tile_entered.on_mouse_exited()
			last_tile_entered = null

	if Input.is_action_just_released('ui_mouse_left'):
		if last_tile_entered != null:
			emit_signal('tile_clicked', last_tile_entered)
