tool
extends StaticBody
class_name HexTile

export(Vector2) var position setget _set_position

var hex_vec: Hex.HexVector = null
var id: int = 0

func _ready() -> void:
	var mat = $MeshInstance.get_surface_material(0).duplicate()
	$MeshInstance.set_surface_material(0, mat)

func _set_position(new_position: Vector2) -> void:
	var x = round(new_position.x)
	var y = round(new_position.y)

	hex_vec = Hex.HexVector.new(x, y)
	position = hex_vec.to_pixel()

	if is_inside_tree():
		global_transform.origin = Vector3(position.x, 0.0, position.y)

func on_mouse_entered() -> void:
	$MeshInstance/AnimationPlayer.play('FloatUp')

func on_mouse_exited() -> void:
	$MeshInstance/AnimationPlayer.play_backwards('FloatUp')

func highlight() -> void:
	$MeshInstance/HighlightPlayer.play('Tint')

func dehighlight() -> void:
	$MeshInstance/HighlightPlayer.play_backwards('Tint')
