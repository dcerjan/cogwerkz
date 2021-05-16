tool
extends Control
class_name CardSlot

export(CommonConcept.SlotType) var type = CommonConcept.SlotType.None
export(Texture) var background = null setget _set_background
export(Resource) var card = null setget _set_card, _get_card
export(Resource) var character = null setget _set_character

var context = null

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

func _set_card(new_card) -> void:
	card = new_card
	refresh()

func _get_card() -> CardConcept:
	return card

func _set_background(new_background: Texture) -> void:
	background = new_background
	refresh()

func refresh() -> void:
	if has_node('Background'): get_node('Background').texture = background
	if card == null:
		if has_node('Icon'): get_node('Icon').texture = null
	else:
		if has_node('Icon'): get_node('Icon').texture = card.icon

func get_drag_data(_position: Vector2):
	if context == null || card == null:
		return null
	context.current_dragged_data = CardDropData.new(self, card)
	var item_icon = TextureRect.new()
	item_icon.texture = card.icon
	set_drag_preview(item_icon)
	card = null
	context.state_changed()
	refresh()
	return context.current_dragged_data

func can_drop_data(_position: Vector2, data: CardDropData) -> bool:
	if data.card.can_slot_into(character, self):
		var own_card = card
		if own_card != null and !own_card._can_slot_into(character, self):
			return false
		return data.card._can_slot_into(character, self)
	return false

func drop_data(_position: Vector2, data: CardDropData) -> void:
	var own_card = card
	if data.card != null and data.slot != null:
		data.slot.card = own_card
		card = data.card
		data.slot.refresh()
		refresh()
		context.current_dragged_data = null
		context.state_changed()
