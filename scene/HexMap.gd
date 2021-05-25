tool
extends Spatial

var tile = preload('res://scene/HexTile.tscn')

export(float) var cell_size = 1.0 setget _set_cell_size

const MAP = [
	[null, null, null,    1,    1,    1,    1],
	[null, null,    1,    1,    1,    1,    1],
	[null,    1,    1,    1,    1,    1,    1],
	[   1,    1,    1,    1,    1,    1,    1],
	[   1,    1,    1,    1,    1,    1, null],
	[   1,    1,    1,    1,    1, null, null],
	[   1,    1,    1,    1, null, null, null],
]

var last_tile_entered = null

func _set_cell_size(new_cell_size: float) -> void:
	cell_size = new_cell_size
	update_tiles()

func _ready() -> void:
	update_tiles()

func update_tiles() -> void:
	var children = get_children()
	for c in children:
		remove_child(c)
		c.queue_free()

	var q = - round(MAP[0].size() / 2)
	var r = - round(MAP.size() / 2)
	for row in MAP:
		for cell in row:
			if cell != null:
				var t = tile.instance()
				add_child(t)
				t.set_owner(self)
				t.position = Vector2(q, r)
			q += 1
		r += 1
		q = - round(MAP[0].size() / 2)

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
