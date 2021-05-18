tool
extends Control

export(Texture) var icon = null setget _set_icon
export(Color) var tint = Color(0xffffffff) setget _set_tint
export(int) var value = '' setget _set_value
export(String, MULTILINE) var description = '' setget _set_description
export(bool) var modifier = false setget _set_modifier

func _set_icon(new_icon: Texture):
	icon = new_icon
	refresh()

func _set_tint(new_tint: Color):
	tint = new_tint
	refresh()

func _set_value(new_value: int):
	value = new_value
	refresh()

func _set_description(new_description: String):
	description = new_description
	refresh()

func _set_modifier(new_modifier: bool) -> void:
	modifier = new_modifier

func refresh() -> void:
	if has_node('Icon'):
		$Icon.texture = icon
		$Icon.modulate = tint
	if has_node('Label'):
		var sign_symbol = ''
		if modifier:
			sign_symbol = '+' if value >= 0 else ''
		$Label.text = sign_symbol + str(value)
	if has_node('Tooltip'):
		$Tooltip.description = description

func _ready() -> void:
	connect('mouse_entered', self, '_on_mouse_entered')
	connect('mouse_exited', self, '_on_mouse_exited')
	refresh()

func _on_mouse_entered() -> void:
	$Icon/AnimationPlayer.play('Highlight')

func _on_mouse_exited() -> void:
	$Icon/AnimationPlayer.play_backwards('Highlight')
