tool
extends CardSlot
class_name DetailCardSlot

const STIPPLE_BACKGROUND = preload('res://assets/sprites/ninepatch_card_border_stippled.png')
const BLACK_BACKGROUND = preload('res://assets/sprites/ninepatch_card_border_black.png')

const AFFINITY_NONE_BACKGROUND = preload('res://assets/sprites/card_background_no_affinity.png')

func _refresh() -> void:
	._refresh()
	if card == null:
		self.texture = STIPPLE_BACKGROUND
		if has_node('CardName'): $CardName.text = ''
		if has_node('Rarity'): $Rarity.modulate = Color(0x00000000)
		if has_node('Background'): $Background.texture = null
	else:
		self.texture = BLACK_BACKGROUND
		if has_node('CardName'): $CardName.text = card.name
		if has_node('Rarity'):
			var color: Color = Color(0x00000000)
			match card.rarity:
				CommonConcept.Rarity.Common: color = Color(0x000000ff)
				CommonConcept.Rarity.Uncommon: color = Color(0xffffffff)
				CommonConcept.Rarity.Rare: color = Color(0xffa100ff)
				CommonConcept.Rarity.Mythic: color = Color(0xca55ffff)
			$Rarity.modulate = color
		if has_node('Background'):
			$Background.texture = AFFINITY_NONE_BACKGROUND
