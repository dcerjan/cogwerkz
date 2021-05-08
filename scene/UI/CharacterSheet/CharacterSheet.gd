extends Control

onready var core = $Core
onready var body = $Body

var test_character_sheet = preload('res://resource/characters/test/HumanTinkerer.tres')

var inventory_state = preload('res://data/character_sheet_concept/inventory_state.tres')

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released('ui_mouse_left') and \
		inventory_state.current_dragged_data is Dictionary and \
		inventory_state.current_dragged_data.slot != null:
			print(inventory_state.current_dragged_data.card.name, inventory_state.current_dragged_data.slot)
			inventory_state.current_dragged_data.slot.card_slot.card = inventory_state.current_dragged_data.card
			inventory_state.current_dragged_data.slot.update_icon()
			inventory_state.current_dragged_data = null
			inventory_state.state_changed()

func _ready() -> void:
	core.sheet = test_character_sheet
