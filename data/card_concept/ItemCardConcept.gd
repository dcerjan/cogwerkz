extends CardConcept
class_name ItemCardConcept

export(int, FLAGS, 'Life', 'Order', 'Balance', 'Chaos', 'Death') var affinity = 0b0
export(int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Greaves', 'Cape', 'Consumable', 'Trinket', 'Gauntlets') var tag = 0

func _can_slot_into(tags: int) -> bool:
	return tags & tag
