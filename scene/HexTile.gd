tool
extends StaticBody
class_name HexTile

export(Vector2) var position setget _set_position

var hex_vec = null

func _set_position(new_position: Vector2) -> void:
	var x = round(new_position.x)
	var y = round(new_position.y)

	hex_vec = Hex.HexVector.new(x, y)
	position = hex_vec.to_pixel()
	global_transform.origin = Vector3(position.x, 0.0, position.y)

func on_mouse_entered() -> void:
	$MeshInstance/AnimationPlayer.play('FloatUp')

func on_mouse_exited() -> void:
	$MeshInstance/AnimationPlayer.play_backwards('FloatUp')
