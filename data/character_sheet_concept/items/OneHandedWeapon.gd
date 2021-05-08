extends Card
class_name OneHandedWeaponCard

func _can_slot_into(slot: CardSlot) -> bool:
	return slot.tags & CardSlot.SlotType.Weapon
