extends Resource
class_name Card

export(String) var name = ''
export(Resource) var card = null

func _can_slot_into(slot: CardSlot) -> bool:
	return false
