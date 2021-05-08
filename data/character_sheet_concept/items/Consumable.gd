extends Card
class_name ConsumableCard

func _can_slot_into(slot: CardSlot) -> bool:
	return slot.tags & CardSlot.SlotType.Consumable
