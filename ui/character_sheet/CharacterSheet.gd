tool
extends Control

export(Resource) var character_sheet = null setget _set_character_sheet

const affinity_life_scene = preload('res://ui/common/AffinityLife.tscn')
const affinity_order_scene = preload('res://ui/common/AffinityOrder.tscn')
const affinity_balance_scene = preload('res://ui/common/AffinityBalance.tscn')
const affinity_chaos_scene = preload('res://ui/common/AffinityChaos.tscn')
const affinity_death_scene = preload('res://ui/common/AffinityDeath.tscn')

var current_dragged_data: CardSlot.CardDropData = null

func _on_race_card_grabbed(card: RaceCardConcept, slot) -> void:
	var sheet: CharacterConcept = character_sheet
	if sheet != null && slot == $RaceSlot:
		sheet.race_card = null

func _on_race_card_dropped(card: RaceCardConcept, slot) -> void:
	var sheet: CharacterConcept = character_sheet
	if sheet != null && slot == $RaceSlot:
		sheet.race_card = card

func _on_class_card_grabbed(card: ClassCardConcept, slot) -> void:
	var sheet: CharacterConcept = character_sheet
	if sheet != null && slot == $ClassSlot:
		sheet.class_card = null

func _on_class_card_dropped(card: ClassCardConcept, slot) -> void:
	var sheet: CharacterConcept = character_sheet
	if sheet != null && slot == $ClassSlot:
		sheet.class_card = card

func subscribe() -> void:
	$RaceSlot.connect('drag_start', self, '_on_race_card_grabbed')
	$RaceSlot.connect('drag_end', self, '_on_race_card_dropped')
	$ClassSlot.connect('drag_start', self, '_on_class_card_grabbed')
	$ClassSlot.connect('drag_end', self, '_on_class_card_dropped')

func _ready() -> void:
	$RaceSlot.context = self
	$ClassSlot.context = self
	$CardPool.context = self
	subscribe()
	_on_character_sheet_changed()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released('ui_mouse_left') && current_dragged_data != null:
		current_dragged_data.slot.card = current_dragged_data.card
		current_dragged_data.slot.emit_signal('drag_end', current_dragged_data.card, current_dragged_data.slot)
		current_dragged_data = null
		_on_character_sheet_changed()

func _set_character_sheet(sheet):
	if character_sheet != null:
		character_sheet.disconnect('changed', self, '_on_character_sheet_changed')
	character_sheet = sheet
	if character_sheet != null:
		character_sheet.connect('changed', self, '_on_character_sheet_changed')
	if is_inside_tree():
		_on_character_sheet_changed()

func _on_character_sheet_changed():
	print('Character sheet changed')
	var character_name = ''
	var race = null
	var clazz = null
	var affinity = 0
	var health = 0
	var max_health = 0
	var armor = 0
	var resistance = 0
	var agility = 0
	var brawn = 0
	var brains = 0

	if character_sheet != null:
		character_name = character_sheet.name
		race = character_sheet.race_card if character_sheet.race_card != null else null
		clazz = character_sheet.class_card if character_sheet.class_card != null else null
		health = character_sheet.health
		max_health = character_sheet.max_health
		affinity = character_sheet.affinity
		armor = character_sheet.armor
		resistance = character_sheet.resistance
		agility = character_sheet.agility
		brawn = character_sheet.brawn
		brains = character_sheet.brains

	$CharacterName.text = 'Name: ' + character_name

	$RaceSlot.card = race
	$ClassSlot.card = clazz
	update_affinity()

	$Agility.value = agility
	$Brawn.value = brawn
	$Brains.value = brains

	$Armor.value = armor
	$Resistance.value = resistance
	$HP.value = max_health

func update_affinity():
	var children = $Affinity.get_children()
	while children.size() > 0:
		$Affinity.remove_child(children[0])

	if character_sheet != null:
		var character_affinity = character_sheet.affinity
		var last_icon_index = 0
		for a in CommonConcept.AFFINITIES:
			if a & character_affinity:
				var scn = null
				match a:
					CommonConcept.Affinity.Life: scn = affinity_life_scene
					CommonConcept.Affinity.Order: scn = affinity_order_scene
					CommonConcept.Affinity.Balance: scn = affinity_balance_scene
					CommonConcept.Affinity.Chaos: scn = affinity_chaos_scene
					CommonConcept.Affinity.Death: scn = affinity_death_scene
					_: scn = null
				if scn != null:
					$Affinity.add_child(scn.instance())
