tool
extends Control

var CardSlotScene = preload('res://ui/inventory/CardSlot.tscn')

export(Array, Resource) var own_cards = [] setget _set_own_cards

onready var grid = $GridContainer

func _ready() -> void:
	_set_own_cards(own_cards)

func _set_own_cards(cards: Array) -> void:
	if cards == null:
		cards = []
	own_cards = cards

	if grid == null:
		return

	var children = grid.get_children()

	if children.size() < own_cards.size():
		for i in range(own_cards.size() - children.size()):
			var new_card_slot = CardSlotScene.instance()
			grid.add_child(new_card_slot)
	elif children.size() > own_cards.size():
		for i in range(children.size() - own_cards.size()):
			var child: Control = children.pop_back()
			child.queue_free()

	children = grid.get_children()

	for i in range(children.size()):
		children[i].card = own_cards[i]
		children[i].enable()
