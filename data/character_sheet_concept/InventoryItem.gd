extends Resource
class_name InventoryItem

export(String) var name = ''
export(Texture) var icon = null

func _can_slot_into(slot: InventorySlot) -> bool:
	return false
