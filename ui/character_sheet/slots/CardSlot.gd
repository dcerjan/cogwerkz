tool
extends NinePatchRect
class_name CardSlot

export(CommonConcept.SlotType) var type = CommonConcept.SlotType.None
export(Texture) var background = null setget _set_background
export(Resource) var card = null setget _set_card, _get_card
export(Resource) var character = null setget _set_character

var context = null

signal drag_start(card, slot)
signal drag_end(card, slot)

class CardDropData:
	extends Object
	var slot: CardSlot setget ,_get_slot
	var card: CardConcept setget ,_get_card

	func _get_slot() -> CardSlot:
		return slot

	func _get_card() -> CardConcept:
		return card

	func _init(in_slot: CardSlot, in_card: CardConcept):
		slot = in_slot
		card = in_card

func _set_character(new_character) -> void:
	character = new_character
	_refresh()

func _set_card(new_card) -> void:
	card = new_card
	_refresh()

func _get_card() -> CardConcept:
	return card

func _set_background(new_background: Texture) -> void:
	background = new_background
	_refresh()

func _refresh() -> void:
	if has_node('Background'): get_node('Background').texture = background
	if card == null:
		if has_node('Icon'): get_node('Icon').texture = null
	else:
		if has_node('Icon'): get_node('Icon').texture = card.icon

func _ready() -> void:
	$Background.connect('mouse_entered', self, '_on_mouse_entered')
	$Background.connect('mouse_exited', self, '_on_mouse_exited')
	$AnimationPlayer.play_backwards('Highlight')
	_refresh()

func _on_mouse_entered() -> void:
	$AnimationPlayer.play('Highlight')
	if context != null: context.notify_hovered_card(card)

func _on_mouse_exited() -> void:
	$AnimationPlayer.play_backwards('Highlight')
	if context != null: context.notify_hovered_card(null)

func get_drag_data(position: Vector2):
	if context == null || card == null:
		return null
	var card_drop_data = CardDropData.new(self, card)
	context.current_dragged_data = card_drop_data
	var preview = _get_drag_preview(context.current_dragged_data, context.character_sheet, position)
	set_drag_preview(preview)
	card = null
	emit_signal('drag_start', card_drop_data.card, self)
	_refresh()
	return context.current_dragged_data

func _get_drag_preview(card_drop_data: CardDropData, character: CharacterConcept, position: Vector2):
	var detail_container = Control.new()
	var detail = load(get_script().resource_path.replace('.gd', '.tscn')).instance()
	detail.card = card_drop_data.card
	detail.character = character
	detail.context = context
	detail.rect_position = -position
	detail.set_script(null)
	detail_container.add_child(detail)
	return detail_container

func can_drop_data(_position: Vector2, data: CardDropData) -> bool:
	if data.card.can_slot_into(context.character_sheet, self):
		var own_card = card
		if own_card != null and !own_card.can_slot_into(context.character_sheet, data.slot):
			return false
		return data.card.can_slot_into(context.character_sheet, self)
	return false

func drop_data(_position: Vector2, data: CardDropData) -> void:
	var own_card = card
	if data.card != null and data.slot != null:
		data.slot.card = own_card
		card = data.card
		data.slot.emit_signal('drag_end', data.slot.card, data.slot)
		data.slot._refresh()
		_refresh()
		context.current_dragged_data = null
	emit_signal('drag_end', card, self)
