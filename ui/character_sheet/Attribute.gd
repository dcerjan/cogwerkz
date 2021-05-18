tool
extends Control

const TOOLTIP = preload('res://ui/character_sheet/Tooltip.tscn')

export(Texture) var icon = null setget _set_icon
export(Color) var tint = Color(0xffffffff) setget _set_tint
export(int) var value = '' setget _set_value
export(String, MULTILINE) var description = '' setget _set_description
export(bool) var modifier = false setget _set_modifier

var tooltip: PanelContainer = null

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

func _ready() -> void:
	connect('mouse_entered', self, '_on_mouse_entered')
	connect('mouse_exited', self, '_on_mouse_exited')
	refresh()

func show_tooltip() -> void:
	tooltip = TOOLTIP.instance()
	tooltip.label = description
	tooltip.rect_position = calc_tooltip_position()
	add_child(tooltip)

func calc_tooltip_position() -> Vector2:
	return get_viewport().get_mouse_position() + Vector2(4, 4)

func hide_tooltip() -> void:
	remove_child(tooltip)

func _on_mouse_entered() -> void:
	if description == '':
		return
	show_tooltip()

func _on_mouse_exited() -> void:
	hide_tooltip()

func _physics_process(delta: float) -> void:
	if tooltip != null:
		tooltip.rect_position = calc_tooltip_position()
