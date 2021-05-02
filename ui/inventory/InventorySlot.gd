extends CenterContainer

var default_slot_sprite = preload('res://assets/sprites/inventory_slot_background.png')
var inventory_state = preload('res://data/inventory_concept/inventory_state.tres')

onready var hovered_sprite_anim = $SlotBackgroundHovered/AnimationPlayer
onready var slotted_item_sprite = $SlotBackground

export(Resource) var inventory_slot = InventorySlot.new()
export(String) var id = ''

func _ready() -> void:
	connect('mouse_entered', self, 'on_mouse_entered')
	connect('mouse_exited', self, 'on_mouse_exited')
	update_icon()
	inventory_state.connect('inventory_state_changed', self, 'on_inventory_state_changed')

func on_inventory_state_changed(state: InventoryState):
	if state.current_dragged_data != null:
		var item: InventoryItem = state.current_dragged_data.item
		if item != null:
			if item._can_slot_into(inventory_slot):
				slotted_item_sprite.modulate.a = 1.0
			else:
				slotted_item_sprite.modulate.a = 0.5
	else:
		slotted_item_sprite.modulate.a = 1.0

func update_icon() -> void:
	if inventory_slot.item != null:
		var item: InventoryItem = inventory_slot.item
		slotted_item_sprite.texture = item.icon
	else:
		slotted_item_sprite.texture = default_slot_sprite

func on_mouse_entered() -> void:
	hovered_sprite_anim.play('FadeIn')
	inventory_state.current_hovered_item = inventory_slot.item

func on_mouse_exited() -> void:
	hovered_sprite_anim.play_backwards('FadeIn')
	inventory_state.current_hovered_item = null

func get_drag_data(position: Vector2):
	var item = inventory_slot.item
	if item == null:
		return null
	else:
		inventory_state.current_dragged_data = {
			'slot': self,
			'item': item,
		}
		var item_icon = TextureRect.new()
		item_icon.texture = inventory_slot.item.icon
		set_drag_preview(item_icon)
		inventory_slot.item = null
		update_icon()
		inventory_state.state_changed()
		return inventory_state.current_dragged_data

func can_drop_data(_position: Vector2, data: Dictionary) -> bool:
	var own_item = inventory_slot.item
	if data is Dictionary and data.item is InventoryItem:
		if own_item != null and !own_item._can_slot_into(data.slot.inventory_slot):
			return false
		return data.item._can_slot_into(inventory_slot)
	return false

func drop_data(_position: Vector2, data: Dictionary) -> void:
	var own_item = inventory_slot.item
	if data is Dictionary and data.item != null and data.slot != null:
		data.slot.inventory_slot.item = own_item
		inventory_slot.item = data.item
		data.slot.update_icon()
		update_icon()
		inventory_state.current_dragged_data = null
		inventory_state.state_changed()
