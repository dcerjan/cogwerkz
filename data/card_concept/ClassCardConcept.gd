extends CardConcept
class_name ClassCardConcept

export(int, FLAGS, 'Life', 'Order', 'Balance', 'Chaos', 'Death') var affinity = 0b0
export(Array, int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Greaves', 'Cape', 'Consumable', 'Trinket', 'Gauntlets', 'Race', 'Class') var body_layout = [
	0,
	0,
	0,

	0,
	0,
	0,

	0,
	0,
	0,
]
export(int) var skill_slots = 0
export(int) var ability_slots = +1
export(int) var spell_slots = 0
export(int) var consumable_slots = +2

export(int) var health = -2
export(int) var armor = 0
export(int) var resistance = 0
export(int) var protection = 0
export(int) var shield = 0
export(int) var initiative = 0
export(int) var speed = 0
export(int) var damage = 0
export(int) var power = 0
