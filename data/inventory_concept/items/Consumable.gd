extends InventoryItem
class_name ConsumableInventoryItem

func _can_slot_into(slot: InventorySlot) -> bool:
	return slot.tags & InventorySlot.SlotType.Consumable
