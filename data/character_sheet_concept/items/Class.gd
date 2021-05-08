extends Card
class_name ClassCard

var resourceDb = preload('res://resource/ResourceDb.gd').new()

func _init() -> void:
	card = resourceDb.cards.clazz.tinkerer

func _can_slot_into(slot: CardSlot) -> bool:
	return slot.tags & CardSlot.SlotType.Class
