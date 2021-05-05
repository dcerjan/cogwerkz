extends InventoryItem
class_name OneHandedWeaponInventoryItem

func _can_slot_into(slot: InventorySlot) -> bool:
	return slot.tags & InventorySlot.SlotType.Weapon
