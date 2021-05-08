extends Card
class_name RaceCard

var resourceDb = preload('res://resource/ResourceDb.gd').new()

func _init() -> void:
	card = resourceDb.cards.race.human

func _can_slot_into(slot: CardSlot) -> bool:
	return slot.tags & CardSlot.SlotType.Race
