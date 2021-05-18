tool
extends TextureRect

export(Color) var tint = Color(0xffffffff) setget _set_tint, _get_tint

func _set_tint(new_tint: Color) -> void: modulate = new_tint
func _get_tint() -> Color: return modulate

func fade_out() -> void:
	$Animation.play('Fade')

func fade_in() -> void:
	$Animation.play_backwards('Fade')
