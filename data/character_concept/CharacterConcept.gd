tool
extends Resource
class_name CharacterConcept

# ============================================================================ #
# Properties
# ============================================================================ #
export(String) var name = 'Unnamed Character' setget _set_name, _get_name

export(Resource) var race_card = null setget _set_race_card
export(Resource) var class_card = null setget _set_class_card

export(int) var health: int = 0 setget _set_health, _get_health
var max_health: int setget, _get_max_health
var armor: int setget, _get_armor
var resistance: int setget, _get_resistance
var brawn: int setget, _get_brawn
var brains: int setget, _get_brains
var agility: int setget, _get_agility

var affinity: int setget, _get_affinity
var equipment_tokens: Array setget, _get_equipment_tokens
var max_abilities: int setget, _get_max_abilities

var equipment = []
var abilities = []
var active_effects = []

# ============================================================================ #
# Setters & Getters
# ============================================================================ #
func _set_name(new_name: String):
	name = new_name
	emit_changed()

func _get_name() -> String:
	return name

func _set_race_card(new_race_card):
	if race_card != null:
		race_card.disconnect('changed', self, 'emit_changed')
		if race_card.icon != null:
			race_card.icon.disconnect('changed', self, 'emit_changed')
	race_card = new_race_card
	if race_card != null:
		race_card.connect('changed', self, 'emit_changed')
		if race_card.icon != null:
			race_card.icon.connect('changed', self, 'emit_changed')
	emit_changed()

func _set_class_card(new_class_card):
	if class_card != null:
		class_card.disconnect('changed', self, 'emit_changed')
	class_card = new_class_card
	if class_card != null:
		class_card.connect('changed', self, 'emit_changed')
	emit_changed()

func _set_health(amount: int) -> void:
	health = amount
	emit_changed()

func _get_health() -> int:
	return health

func _get_max_health() -> int:
	return _get_current_attribute_value('health')

func _get_armor() -> int:
	return _get_current_attribute_value('armor')

func _get_resistance() -> int:
	return _get_current_attribute_value('resistance')

func _get_brawn() -> int:
	return _get_current_attribute_value('brawn')

func _get_brains() -> int:
	return _get_current_attribute_value('brains')

func _get_agility() -> int:
	return _get_current_attribute_value('agility')

func _get_affinity() -> int:
	var affinity = 0
	affinity = race_card.affinity if race_card != null else 0
	affinity &= class_card.affinity if class_card != null else -1
	return affinity

func _get_equipment_tokens() -> Array:
	var tokens = []
	if race_card != null:
		for token in race_card.equipment_tokens:
			tokens.push_back(token)

	if class_card != null:
		# keep only tokens class does not explicitly remove
		if class_card.remove_equipment_tokens.size():
			var tokens_copy: Array = [] + tokens
			var remove_tokens: Array = [] + class_card.remove_equipment_tokens

			while remove_tokens.size():
				var test = remove_tokens.pop_back()
				for i in range(tokens_copy.size()):
					if tokens_copy[i] & test:
						tokens_copy[i] = 0

		# and add tokens class explicitly adds
		for token in class_card.add_equipment_tokens:
			tokens.push_back(token)

	var free_tokens = []
	# and remove tokens consumed by equipped items
	var tokens_copy: Array = [] + tokens
	for item in equipment:
		var cost: Array = [] + item.cost

		while cost.size():
			var test = cost.pop_back()
			for i in range(tokens_copy.size()):
				if tokens_copy[i] & test:
					tokens_copy[i] = 0

	tokens = []
	for token in tokens_copy:
		if token != 0:
			tokens.push_back(token)

	return free_tokens

func _get_max_abilities() -> int:
	return _get_current_attribute_value('abilities')

# ============================================================================ #
# Utility
# ============================================================================ #
func _get_original_attribute_value(attribute: String) -> int:
	var attr = 0
	attr += self.race_card.get(attribute) if self.race_card != null && attribute in self.race_card else 0
	attr += class_card.get(attribute) if class_card != null && attribute in class_card else 0
	for ability in abilities:
		attr += ability.get(attribute) if attribute in ability else 0
	for item in equipment:
		attr += item.get(attribute) if attribute in item else 0
	return attr

func _get_current_attribute_value(attribute: String):
	var attr = _get_original_attribute_value(attribute)
	for active_effect in active_effects:
		attr += active_effect.get(attribute) if attribute in active_effect else 0
	return attr

# ============================================================================ #
# Methods
# ============================================================================ #
func can_add_item(item) -> bool:
	var cost: Array = [] + item.cost
	if cost.size() == 0:
		print('WARN: Item ' + item.name + ' has invalid cost array [], provide at least one cost token')
		return false

	var tokens_to_consume = cost.size()
	for token in equipment_tokens:
		var test = cost.back()
		if token & test:
			cost.pop_back()
			if cost.size() == 0:
				return item.affinity & affinity

	return false

func add_item(item):
	equipment.push_back(item)
	emit_changed()

func can_add_ability(ability) -> bool:
	return max_abilities > 0 && ability.affinity & affinity

func add_ability(ablity):
	abilities.push_back(ablity)
	emit_changed()

func add_active_effect(effect):
	active_effects.push_back(effect)
	emit_changed()
