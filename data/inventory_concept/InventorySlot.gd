extends Resource
class_name InventorySlot

enum SlotType {
	Weapon     = 0b000000000001,
	Armor      = 0b000000000010,
	Shield     = 0b000000000100,
	Helmet     = 0b000000001000,
	Boots      = 0b000000010000,
	Cape       = 0b000000100000,
	Consumable = 0b000001000000,
	Trinket    = 0b000010000000,
}

export(int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Boots', 'Cape', 'Consumable', 'Trinket') var tags = 0
export(bool) var disabled = true
export(Resource) var item = null

export(Texture) var slot_background = null
export(Texture) var slot_decoration = null
