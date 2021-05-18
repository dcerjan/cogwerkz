tool
extends TextureRect

export(Color) var tint = Color(0xffffffff) setget _set_tint, _get_tint

func _set_tint(new_tint: Color) -> void: modulate = new_tint
func _get_tint() -> Color: return modulate

var is_visible = true

func fade_out() -> void:
	if is_visible:
		is_visible = false
		$Animation.play('Fade')

func fade_in() -> void:
	if !is_visible:
		is_visible = true
		$Animation.play_backwards('Fade')

func _ready() -> void:
	if is_visible:
		fade_in()
	else:
		fade_out()
