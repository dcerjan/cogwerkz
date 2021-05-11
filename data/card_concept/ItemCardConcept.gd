extends CardConcept
class_name ItemCardConcept

export(int, FLAGS, 'Life', 'Order', 'Balance', 'Chaos', 'Death') var affinity = 0b0

enum EquipmentToken {
	None       = 0b0000000000000000,
	Weapon     = 0b0000000000000001,
	Armor      = 0b0000000000000010,
	Shield     = 0b0000000000000100,
	Helmet     = 0b0000000000001000,
	Greaves    = 0b0000000000010000,
	Cape       = 0b0000000000100000,
	Consumable = 0b0000000001000000,
	Trinket    = 0b0000000010000000,
	Gauntlets  = 0b0000000100000000,
}
export(Array, EquipmentToken) var cost = []
