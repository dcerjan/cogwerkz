extends Spatial

onready var character_handle = get_node('../Character')
onready var tile_map: HexMap = get_node('../HexMap')

const NEIGHBOUR_OFFSETS = [
	{ 'q':+1, 'r': 0 },
	{ 'q':+1, 'r':-1 },
	{ 'q': 0, 'r':-1 },
	{ 'q':-1, 'r': 0 },
	{ 'q':-1, 'r':+1 },
	{ 'q': 0, 'r':+1 },
]

var a_star: AStar = AStar.new()
var point_index = {}

func _ready() -> void:
	tile_map.connect('tile_map_updated', self, '_on_tile_map_updated')
	tile_map.connect('tile_clicked', self, '_on_tile_clicked')
	_on_tile_map_updated(tile_map)

func _on_tile_map_updated(tilemap: HexMap) -> void:
	a_star.clear()
	point_index = {}

	# rebuild astar index
	for row_key in tilemap.tiles:
		var row_index = {}
		for tile_key in tile_map.tiles[row_key]:
			var tile: HexTile = tilemap.tiles[row_key][tile_key]
			if tile != null:
				var pos = tile.hex_vec.to_pixel()
				a_star.add_point(tile.id, Vector3(pos.x, 0, pos.y))
				row_index[tile_key] = tile
			else:
				row_index[tile_key] = null
		point_index[row_key] = row_index

	# connect neighbouring points
	for q in point_index:
		for r in point_index[q]:
			var tile = point_index[q][r]
			if tile != null:
				for offset in NEIGHBOUR_OFFSETS:
					if point_index.has(q + offset.q) && point_index[q + offset.q].has(r + offset.r):
						var neighbour = point_index[q + offset.q][r + offset.r]
						if neighbour != null:
							a_star.connect_points(tile.id, neighbour.id, false)

func _on_tile_clicked(tile: HexTile) -> void:
	if !is_inside_tree(): return

	var from = a_star.get_closest_point(character_handle.global_transform.origin)
	var to = tile.id
	character_handle.move_along_path(a_star.get_point_path(from, to), a_star.get_id_path(from, to))
