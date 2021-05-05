extends CardConcept
class_name RaceCardConcept

export(int, FLAGS, 'Life', 'Order', 'Balance', 'Chaos', 'Death') var affinity = 0b0
export(Array, int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Greaves', 'Cape', 'Consumable', 'Trinket', 'Gauntlets', 'Race', 'Class') var body_layout = [
	CommonConcept.SlotType.Greaves,
	CommonConcept.SlotType.Helmet,
	CommonConcept.SlotType.Cape,

	CommonConcept.SlotType.Weapon | CommonConcept.SlotType.Shield,
	CommonConcept.SlotType.Armor,
	CommonConcept.SlotType.Weapon | CommonConcept.SlotType.Shield,

	CommonConcept.SlotType.Trinket,
	CommonConcept.SlotType.Greaves,
	CommonConcept.SlotType.Trinket,
]
export(int) var skill_slots = 0
export(int) var ability_slots = 0
export(int) var spell_slots = 0
export(int) var consumable_slots = 0

export(int) var health = 0
export(int) var armor = 0
export(int) var resistance = 0
export(int) var protection = 0
export(int) var shield = 0
export(int) var initiative = 0
export(int) var speed = 0
export(int) var damage = 0
export(int) var power = 0
