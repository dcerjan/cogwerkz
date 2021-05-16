tool
extends CardSlot
class_name DetailCardSlot

func refresh() -> void:
	.refresh()
	if card == null:
		if has_node('CardName'): get_node('CardName').text = ''
	else:
		if has_node('CardName'): get_node('CardName').text = card.name
