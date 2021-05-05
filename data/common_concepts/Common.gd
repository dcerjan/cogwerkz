extends Object
class_name CommonConcept

enum SlotType {
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
	Race       = 0b0000001000000000,
	Class      = 0b0000010000000000,
}

enum Affinity {
	Life    = 0b00010000, # white
	Order   = 0b00001000, # Blue
	Balance = 0b00000010, # Green
	Chaos   = 0b00000001, # Red
	Death   = 0b00100000, # black
}

enum Rarity {
	Common   = 0b0001
	Uncommon = 0b0010
	Rare     = 0b0100
	Mythic   = 0b1000
}
