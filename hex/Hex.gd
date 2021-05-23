extends Object
class_name Hex

class HexCube:
	extends Object
	func _init(x: float, y: float, z: float) -> void:
		self.x = x
		self.y = y
		self.z = z

class HexVector:
	extends Object

	var q: int
	var r: int

	func _init(q: int, r: int) -> void:
		self.q = q
		self.r = r

	func to_pixel() -> Vector2:
		var px = 3.0 / 2.0 * q
		var py = (sqrt(3.0) / 2.0 * q + sqrt(3.0) * r)
		return Vector2(px, py)

static func from_pixel(position: Vector2) -> HexVector:
	var q = ( 2.0 / 3.0 * position.x)
	var r = (-1.0 / 3.0 * position.x + sqrt(3.0) / 3.0 * position.y)
	return hex_round(HexVector.new(q, r))

static func hex_round(hex: HexVector):
	return cube_to_axial(cube_round(axial_to_cube(hex)))

static func cube_to_axial(cube: HexCube):
	return HexVector.new(cube.x, cube.z)

static func axial_to_cube(hex: HexVector):
	return HexCube.new(hex.q, -hex.q -hex.r, hex.r)

static func cube_round(cube: HexCube):
	var rx = round(cube.x)
	var ry = round(cube.y)
	var rz = round(cube.z)

	var x_diff = abs(rx - cube.x)
	var y_diff = abs(ry - cube.y)
	var z_diff = abs(rz - cube.z)

	if x_diff > y_diff and x_diff > z_diff:
		rx = -ry -rz
	elif y_diff > z_diff:
		ry = -rx -rz
	else:
		rz = -rx -ry

	return HexCube.new(rx, ry, rz)
