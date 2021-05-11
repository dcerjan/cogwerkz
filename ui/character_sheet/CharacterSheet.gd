tool
extends Control

export(Resource) var character_sheet = null setget _set_character_sheet

func _set_character_sheet(sheet):
	if character_sheet != null:
		character_sheet.disconnect('changed', self, '_on_character_sheet_changed')
	character_sheet = sheet
	if character_sheet != null:
		character_sheet.connect('changed', self, '_on_character_sheet_changed')
		_on_character_sheet_changed()

func _on_character_sheet_changed():
	print('Character sheet changed')
	var character_name = ''
	var race = ''
	var clazz = ''
	var affinity = ''
	var health = ''
	var max_health = ''
	var armor = ''
	var resistance = ''
	var agility = ''
	var brawn = ''
	var brains = ''

	if character_sheet != null:
		name = character_sheet.name
		race = character_sheet.race_card.name if character_sheet.race_card != null else ''
		clazz = character_sheet.class_card.name if character_sheet.class_card != null else ''
		health = str(character_sheet.health)
		max_health = str(character_sheet.max_health)
		affinity = CommonConcept.Formatter.format_affinity(character_sheet.affinity)
		armor = str(character_sheet.armor)
		resistance = str(character_sheet.resistance)
		agility = str(character_sheet.agility)
		brawn = str(character_sheet.brawn)
		brains = str(character_sheet.brains)

	$CharacterName.text = 'Name: ' + name
	$RaceClass.text = 'Type: ' + race + ' - ' + clazz
	$Affinity.text = 'Affinity: ' + affinity
	$Health.text = 'HP ' + health + '/' + max_health
	$Armor.text = 'Armor: ' + armor
	$Resistance.text = 'Resistance: ' + resistance
	$Agility.text = 'Agility: ' + agility
	$Brawn.text = 'Brawn: ' + brawn
	$Brains.text = 'Brains: ' + brains