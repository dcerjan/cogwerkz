tool
extends CardConcept
class_name ClassCardConcept

export(int, FLAGS, 'Life', 'Order', 'Balance', 'Chaos', 'Death') var affinity = 0b0001111 setget _set_affinity

export(
	Array, int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Greaves', 'Cape', 'Consumable', 'Trinket', 'Gauntlets'
) var remove_equipment_tokens = [] setget _set_remove_equipment_tokens
export(
	Array, int, FLAGS, 'Weapon', 'Armor', 'Shield', 'Helmet', 'Greaves', 'Cape', 'Consumable', 'Trinket', 'Gauntlets'
) var add_equipment_tokens = [] setget _set_add_equipment_tokens

export(int) var abilities = 0 setget _set_abilities

export(int) var health = 0 setget _set_health

export(int) var armor = 0 setget _set_armor
export(int) var resistance = 0 setget _set_resistance
export(int) var agility = 0 setget _set_agility
export(int) var brawn = 0 setget _set_brawn
export(int) var brains = 0 setget _set_brains

func _set_affinity(new_affinity):
	affinity = new_affinity
	emit_changed()

func _set_remove_equipment_tokens(new_remove_equipment_tokens):
	remove_equipment_tokens = new_remove_equipment_tokens
	emit_changed()

func _set_add_equipment_tokens(new_add_equipment_tokens):
	add_equipment_tokens = new_add_equipment_tokens
	emit_changed()

func _set_abilities(new_abilities):
	abilities = new_abilities
	emit_changed()

func _set_health(new_health):
	health = new_health
	emit_changed()

func _set_armor(new_armor):
	armor = new_armor
	emit_changed()

func _set_resistance(new_resistance):
	resistance = new_resistance
	emit_changed()

func _set_agility(new_agility):
	agility = new_agility
	emit_changed()

func _set_brawn(new_brawn):
	brawn = new_brawn
	emit_changed()

func _set_brains(new_brains):
	brains = new_brains
	emit_changed()

func can_slot_into(character, slot) -> bool:
	var has_character = character != null and character is CharacterConcept
	return has_character && slot.type == CommonConcept.SlotType.Class
