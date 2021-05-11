extends Resource
class_name InventoryState

var current_dragged_data = null
var current_hovered_card = null

signal inventory_state_changed(inventory)

func state_changed() -> void:
	emit_signal('inventory_state_changed', self)
