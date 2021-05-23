tool
extends Spatial

export(Vector2) var position setget _set_position

var hex_vec = null
var elapsed = 0

func _set_position(new_position: Vector2) -> void:
	var x = round(new_position.x)
	var y = round(new_position.y)

	hex_vec = Hex.HexVector.new(x, y)
	position = hex_vec.to_pixel()
	print('(', position.x, ',', position.y, ')')
	global_transform.origin = Vector3(position.x, 0.0, position.y)
	elapsed += randf()

func _physics_process(delta: float) -> void:
	elapsed += delta
	global_transform.origin.y = sin(elapsed)
