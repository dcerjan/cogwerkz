extends Resource
class_name CardSlot

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
		slot_background = card.card.icon
