tool
extends Resource
class_name CharacterSheetConcept

export(Resource) var race_card = null setget _set_race_card
export(Resource) var class_card = null setget _set_class_card

func _set_race_card(card: Resource) -> void:
	if card != null:
		assert(card is RaceCardConcept, "ERROR: Card must be an instancce of RaceCardConcept or null")
	race_card = card
	emit_changed()

func _set_class_card(card: Resource) -> void:
	if card != null:
		assert(card is ClassCardConcept, "ERROR: Card must be an instancce of ClassCardConcept or null")
	class_card = card
	emit_changed()

func _init() -> void:
	emit_changed()
