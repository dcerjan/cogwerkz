tool
extends Resource
class_name CardConcept

export(String) var name = 'Unnamed Card'

export(CommonConcept.Rarity) var rarity = CommonConcept.Rarity.Common setget _set_rarity
export(Texture) var icon = null setget _set_icon
export(CommonConcept.Affinity, FLAGS) var affinity = 0 setget _set_affinity
export(CommonConcept.CardType) var type = CommonConcept.CardType.Race setget _set_type

func _set_rarity(new_rarity) -> void:
	rarity = new_rarity
	emit_changed()

func _set_icon(new_icon: Texture) -> void:
	icon = new_icon
	emit_changed()

func _set_affinity(new_affinity: int) -> void:
	affinity = new_affinity
	emit_changed()

func _set_type(new_type: int) -> void:
	type = new_type
	emit_changed()

func can_slot_into(character, slot) -> bool:
	return slot.type == CommonConcept.SlotType.Backpack
