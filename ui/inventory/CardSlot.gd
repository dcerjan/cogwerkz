tool
extends CenterContainer

var default_slot_sprite = preload('res://assets/sprites/inventory_slot_background.png')
var inventory_state = preload('res://data/character_sheet_concept/inventory_state.tres')

onready var hovered_sprite_anim = $SlotBackgroundHovered/AnimationPlayer
onready var slotted_item_sprite = $SlotBackground

enum SlotType {
	Weapon     = 0b0000000000000001,
	Armor      = 0b0000000000000010,
	Shield     = 0b0000000000000100,
	Helmet     = 0b0000000000001000,
	Greaves    = 0b0000000000010000,
	Cape       = 0b0000000000100000,
	Consumable = 0b0000000001000000,
	Trinket    = 0b0000000010000000,
	Gauntlets  = 0b0000000100000000,
	Race       = 0b0000001000000000,
	Class      = 0b0000010000000000,
}

export(int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Greaves', 'Cape', 'Consumable', 'Trinket', 'Gauntlets', 'Race', 'Class') var tags = -1
export(bool) var disabled = true
export(Resource) var card = null setget _set_card

export(Texture) var slot_background = null
export(Texture) var slot_decoration = null

func _set_card(new_card) -> void:
	card = new_card

	if card != null:
		update_icon()

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
			if card._can_slot_into(tags):
				slotted_item_sprite.modulate.a = 1.0
			else:
				slotted_item_sprite.modulate.a = 0.5
	else:
		slotted_item_sprite.modulate.a = 1.0

func update_icon() -> void:
	if card != null:
		slotted_item_sprite.texture = card.icon
	else:
		slotted_item_sprite.texture = default_slot_sprite

func on_mouse_entered() -> void:
	hovered_sprite_anim.play('FadeIn')
	inventory_state.current_hovered_card = card

func on_mouse_exited() -> void:
	hovered_sprite_anim.play_backwards('FadeIn')
	inventory_state.current_hovered_card = null

func get_drag_data(_position: Vector2):
	if disabled:
		return null

	if card == null:
		return null
	else:
		inventory_state.current_dragged_data = {
			'slot': self,
			'card': card,
		}
		var item_icon = TextureRect.new()
		item_icon.texture = card.icon
		set_drag_preview(item_icon)
		card = null
		update_icon()
		inventory_state.state_changed()
		return inventory_state.current_dragged_data

func can_drop_data(_position: Vector2, data: Dictionary) -> bool:
	if disabled:
		return false

	var own_item = card
	if data is Dictionary and data.card is CardConcept:
		if own_item != null and !own_item._can_slot_into(data.slot.tags):
			return false
		return data.card._can_slot_into(tags)
	return false

func drop_data(_position: Vector2, data: Dictionary) -> void:
	var own_card = card
	if data is Dictionary and data.card != null and data.slot != null:
		data.slot.card = own_card
		card = data.card
		data.slot.update_icon()
		update_icon()
		inventory_state.current_dragged_data = null
		inventory_state.state_changed()
