extends CardConcept
class_name ItemCardConcept


export(Array, CommonConcept.EquipmentToken) var cost = []

func can_slot_into(character, slot) -> bool:
	return (
		.can_slot_into(character, slot) ||
		slot.type == CommonConcept.SlotType.Equipment
	)
