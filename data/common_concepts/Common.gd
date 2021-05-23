extends Object
class_name CommonConcept

class Functional:
	static func map(array: Array, function: FuncRef) -> Array:
		var mapped_array = []
		for val in array:
			mapped_array.push_back(function.call_func(val))
		return mapped_array

	static func filter(array: Array, predicate: FuncRef) -> Array:
		var filtered_array = []
		for val in array:
			if predicate.call_func(val):
				filtered_array.push_back(val)
		return filtered_array

	static func reduce(array: Array, reducer: FuncRef, initial_state):
		var state = initial_state
		for val in array:
			state = reducer.call_func(state, val)
		return state

class Predicate:
	static func non_zero(val: int) -> bool:
		return val != 0

class Lambda:
	func apply(params: Array):
		pass

enum SlotType {
	None       = 0b0000000000000000,
	Race       = 0b0000000000000001,
	Class      = 0b0000000000000010,
	Equipment  = 0b0000000000000100,
	Backpack   = -1,
}

enum CardType {
	Race       = 0b0000000000000001,
	Class      = 0b0000000000000010,
	Equipment  = 0b0000000000000100,
	Skill      = 0b0000000000001000,
	Ability    = 0b0000000000010000,
	Spell      = 0b0000000000100000,
}

enum EquipmentToken {
	None        = 0b0000000000000000,
	Weapon      = 0b0000000000000001,
	Armor       = 0b0000000000000010,
	Shield      = 0b0000000000000100,
	Helmet      = 0b0000000000001000,
	Greaves     = 0b0000000000010000,
	Cape        = 0b0000000000100000,
	Consumable  = 0b0000000001000000,
	Trinket     = 0b0000000010000000,
	Gauntlets   = 0b0000000100000000,
	Skill       = 0b0000001000000000,
	Ability     = 0b0000010000000000,
	Spell       = 0b0000100000000000,
}

enum Affinity {
	Life    = 0b00000001, # white
	Order   = 0b00000010, # Blue
	Balance = 0b00000100, # Green
	Chaos   = 0b00001000, # Red
	Death   = 0b00010000, # black
}
const AFFINITIES = [
	Affinity.Life,
	Affinity.Order,
	Affinity.Balance,
	Affinity.Chaos,
	Affinity.Death,
]

enum Rarity {
	Common   = 0b0001
	Uncommon = 0b0010
	Rare     = 0b0100
	Mythic   = 0b1000
}

class Formatter:
	static func format_rarity(rarity: int) -> String:
		match rarity:
			Rarity.Common: return 'Common'
			Rarity.Common: return 'Uncommon'
			Rarity.Common: return 'Rare'
			Rarity.Common: return 'Mythic'
			_: return ''

	static func format_affinity(affinity: int) -> String:
		var affinities = []
		for flag in [Affinity.Life, Affinity.Order, Affinity.Balance, Affinity.Chaos, Affinity.Death]:
			if affinity & flag:
				match flag:
					Affinity.Life: affinities.push_back('Life')
					Affinity.Order: affinities.push_back('Order')
					Affinity.Balance: affinities.push_back('Balance')
					Affinity.Chaos: affinities.push_back('Chaos')
					Affinity.Death: affinities.push_back('Death')
		return PoolStringArray(affinities).join(' - ')

	static func format_card_type(card_type: int) -> String:
		match card_type:
			CardType.Race: return 'Race Card'
			CardType.Class: return 'Class Card'
			CardType.Equipment: return 'Equipment Card'
			CardType.Skill: return 'SKill Card'
			CardType.Ability: return 'Ability Card'
			CardType.Spell: return 'Spell Card'
		return ''
