tool
extends CardSlot
class_name DetailCardSlot

func refresh() -> void:
	.refresh()
	if card == null:
		if has_node('CardName'): get_node('CardName').text = ''
		if has_node('Rarity'): get_node('Rarity').modulate = Color(0x00000000)
	else:
		if has_node('CardName'): get_node('CardName').text = card.name
		if has_node('Rarity'):
			var color: Color = Color(0x00000000)
			match card.rarity:
				CommonConcept.Rarity.Common: color = Color(0x000000ff)
				CommonConcept.Rarity.Uncommon: color = Color(0xffffffff)
				CommonConcept.Rarity.Rare: color = Color(0xffe300ff)
				CommonConcept.Rarity.Mythic: color = Color(0x8617ffff)
			get_node('Rarity').modulate = color
