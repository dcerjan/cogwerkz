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
