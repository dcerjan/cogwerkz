tool
extends Control

const TOOLTIP = preload('res://ui/character_sheet/Tooltip.tscn')

export(Texture) var icon = null setget _set_icon
export(String) var label = '' setget _set_label
export(String, MULTILINE) var description = '' setget _set_description

var is_ready = false
var tooltip: PanelContainer = null

func _set_icon(new_icon: Texture):
	icon = new_icon
	if is_ready:
		$Icon.texture = icon

func _set_label(new_label: String):
	label = new_label
	if is_ready:
		$Label.text = label

func _set_description(new_description: String):
	description = new_description

func _ready() -> void:
	is_ready = true
	connect('mouse_entered', self, '_on_mouse_entered')
	connect('mouse_exited', self, '_on_mouse_exited')
	$Icon.texture = icon
	$Label.text = label

func show_tooltip() -> void:
	tooltip = TOOLTIP.instance()
	tooltip.label = description
	add_child(tooltip)

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
		tooltip.rect_position = get_viewport().get_mouse_position() + Vector2(4, 4)
