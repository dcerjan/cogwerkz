tool
extends Control

export(Resource) var character_sheet = null setget _set_character_sheet

const AFFINITY_LIFE = preload('res://assets/sprites/mini_icons_affinity_life.png')
const AFFINITY_ORDER = preload('res://assets/sprites/mini_icons_affinity_order.png')
const AFFINITY_BALANCE = preload('res://assets/sprites/mini_icons_affinity_balance.png')
const AFFINITY_CHAOS = preload('res://assets/sprites/mini_icons_affinity_chaos.png')
const AFFINITY_DEATH = preload('res://assets/sprites/mini_icons_affinity_death.png')
const AFFINITY_NONE = preload('res://assets/sprites/mini_icons_affinity_none.png')

onready var affinity_icons = [
	$Affinity/Icon1,
	$Affinity/Icon2,
	$Affinity/Icon3,
	$Affinity/Icon4,
	$Affinity/Icon5,
]

var current_dragged_data: CardSlot.CardDropData = null

func _ready() -> void:
	$RaceSlot.context = self
	$ClassSlot.context = self
	$CardPool.context = self
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
	var health = '0'
	var max_health = '0'
	var armor = '0'
	var resistance = '0'
	var agility = '0'
	var brawn = '0'
	var brains = '0'

	if character_sheet != null:
		character_name = character_sheet.name
		race = character_sheet.race_card if character_sheet.race_card != null else null
		clazz = character_sheet.class_card if character_sheet.class_card != null else null
		health = str(character_sheet.health)
		max_health = str(character_sheet.max_health)
		affinity = character_sheet.affinity
		armor = str(character_sheet.armor)
		resistance = str(character_sheet.resistance)
		agility = str(character_sheet.agility)
		brawn = str(character_sheet.brawn)
		brains = str(character_sheet.brains)

	$CharacterName.text = 'Name: ' + character_name

	$RaceSlot.card = race
	$ClassSlot.card = clazz
	update_affinity()

	$Agility.label = agility
	$Brawn.label = brawn
	$Brains.label = brains

	$Armor.label = armor
	$Resistance.label = resistance
	$HP.label = health + '/' + max_health

func update_affinity():
	var i = 0

	for a in affinity_icons:
		a.texture = null

	if character_sheet != null:
		var character_affinity = character_sheet.affinity
		var last_icon_index = 0
		for a in CommonConcept.AFFINITIES:
			if a & character_affinity:
				var tex: Texture = null
				match a:
					CommonConcept.Affinity.Life: tex = AFFINITY_LIFE
					CommonConcept.Affinity.Order: tex = AFFINITY_ORDER
					CommonConcept.Affinity.Balance: tex = AFFINITY_BALANCE
					CommonConcept.Affinity.Chaos: tex = AFFINITY_CHAOS
					CommonConcept.Affinity.Death: tex = AFFINITY_DEATH
					_: tex = null
				if tex != null:
					affinity_icons[last_icon_index].texture = tex
					last_icon_index += 1
		if last_icon_index == 0:
			affinity_icons[0].texture = AFFINITY_NONE
