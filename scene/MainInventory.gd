extends Control

var inventory_state = preload('res://data/inventory_concept/inventory_state.tres')

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released('ui_mouse_left') and \
		inventory_state.current_dragged_data is Dictionary and \
		inventory_state.current_dragged_data.slot != null:
			print(inventory_state.current_dragged_data.item.name, inventory_state.current_dragged_data.slot)
			inventory_state.current_dragged_data.slot.inventory_slot.item = inventory_state.current_dragged_data.item
			inventory_state.current_dragged_data.slot.update_icon()
			inventory_state.current_dragged_data = null
			inventory_state.state_changed()
