extends CenterContainer

var default_slot_sprite = preload('res://assets/sprites/inventory_slot_background.png')
var inventory_state = preload('res://data/character_sheet_concept/inventory_state.tres')

onready var hovered_sprite_anim = $SlotBackgroundHovered/AnimationPlayer
onready var slotted_item_sprite = $SlotBackground

export(Resource) var card_slot = CardSlot.new()

export(bool) var disabled = true

func enable() -> void:
	disabled = false
	slotted_item_sprite.modulate.a = 1.0

func disable() -> void:
	disabled = true
	slotted_item_sprite.modulate.a = 0.5

func _ready() -> void:
	disable() if disabled else enable()

	connect('mouse_entered', self, 'on_mouse_entered')
	connect('mouse_exited', self, 'on_mouse_exited')
	update_icon()
	inventory_state.connect('inventory_state_changed', self, 'on_inventory_state_changed')

func on_inventory_state_changed(state: InventoryState):
	if disabled:
		return

	if state.current_dragged_data != null:
		var card = state.current_dragged_data.card
		if card != null:
			if card._can_slot_into(card_slot):
				slotted_item_sprite.modulate.a = 1.0
			else:
				slotted_item_sprite.modulate.a = 0.5
	else:
		slotted_item_sprite.modulate.a = 1.0

func update_icon() -> void:
	if card_slot.card != null:
		var card = card_slot.card
		slotted_item_sprite.texture = card.card.icon
	else:
		slotted_item_sprite.texture = default_slot_sprite

func on_mouse_entered() -> void:
	hovered_sprite_anim.play('FadeIn')
	inventory_state.current_hovered_card = card_slot.card

func on_mouse_exited() -> void:
	hovered_sprite_anim.play_backwards('FadeIn')
	inventory_state.current_hovered_card = null

func get_drag_data(_position: Vector2):
	if disabled:
		return null

	var card = card_slot.card
	if card == null:
		return null
	else:
		inventory_state.current_dragged_data = {
			'slot': self,
			'card': card,
		}
		var item_icon = TextureRect.new()
		item_icon.texture = card.card.icon
		set_drag_preview(item_icon)
		card_slot.card = null
		update_icon()
		inventory_state.state_changed()
		return inventory_state.current_dragged_data

func can_drop_data(_position: Vector2, data: Dictionary) -> bool:
	if disabled:
		return false

	var own_item = card_slot.card
	if data is Dictionary and data.card is Card:
		if own_item != null and !own_item._can_slot_into(data.slot.card_slot):
			return false
		return data.card._can_slot_into(card_slot)
	return false

func drop_data(_position: Vector2, data: Dictionary) -> void:
	var own_card = card_slot.card
	if data is Dictionary and data.card != null and data.slot != null:
		data.slot.card_slot.card = own_card
		card_slot.card = data.card
		data.slot.update_icon()
		update_icon()
		inventory_state.current_dragged_data = null
		inventory_state.state_changed()
