extends CardConcept
class_name ItemCardConcept

export(int, FLAGS, 'Life', 'Order', 'Balance', 'Chaos', 'Death') var affinity = 0b0


export(Array, CommonConcept.EquipmentToken) var cost = []

func can_slot_into(character, slot) -> bool:
	return (
		.can_slot_into(character, slot) ||
		slot.type == CommonConcept.SlotType.Equipment
	)
