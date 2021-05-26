extends Spatial

const SPEED = 5.0

export(int) var q = 0 setget _set_q
export(int) var r = 0 setget _set_r

var hex: Hex.HexVector = Hex.HexVector.new(q, r)
var current_path: PoolVector3Array = []
var current_id_path: PoolIntArray = []

func _set_q(new_q: int) -> void:
	q = new_q
	hex.q = q

func _set_r(new_r: int) -> void:
	r = new_r
	hex.r = r

func move_along_path(path: PoolVector3Array, path_id: PoolIntArray) -> void:
	if !is_inside_tree(): return

	var tiles: HexMap = get_node('../HexMap')

	if current_id_path.size() > 0:
		for id in current_id_path:
			tiles.tiles_by_id[id].dehighlight()

	current_path = path
	current_id_path = path_id

	for id in current_id_path:
		tiles.tiles_by_id[id].highlight()

	if path.size() > 1:
		current_path.remove(0)

func _physics_process(delta: float) -> void:
	if !is_inside_tree(): return

	if current_path.size() > 0:
		var target_position = current_path[0]
		var position = global_transform.origin
		if position.distance_to(target_position) > SPEED * delta:
			var direction: Vector3 = (target_position - position)
			global_transform.origin += direction.normalized() * SPEED * delta
		else:
			current_path.remove(0)
			var id = current_id_path[0]
			current_id_path.remove(0)
			var tiles: HexMap = get_node('../HexMap')
			tiles.tiles_by_id[id].dehighlight()
