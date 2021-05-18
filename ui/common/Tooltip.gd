extends PanelContainer

export(String, MULTILINE) var description = '' setget _set_description

func _set_description(new_description: String) -> void:
	description = new_description
	if has_node('Text'):
		$Text.text = description

func _ready() -> void:
	visible = false
	var parent = get_parent()
	parent.connect('mouse_entered', self, '_on_mouse_entered')
	parent.connect('mouse_exited', self, '_on_mouse_exited')

func _on_mouse_entered() -> void:
	if description == '': return

	visible = true
	set_as_toplevel(true)
	rect_position = calc_tooltip_position()
	$AnimationPlayer.play_backwards('Fade')

func _on_mouse_exited() -> void:
	if description == '': return

	$AnimationPlayer.play('Fade')
	yield ($AnimationPlayer, 'animation_finished')
	set_as_toplevel(false)
	visible = false

func calc_tooltip_position() -> Vector2:
	return get_viewport().get_mouse_position() + Vector2(16, 16)

func _physics_process(delta: float) -> void:
	if visible:
		rect_position = calc_tooltip_position()
