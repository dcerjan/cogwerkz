tool
extends ScrollContainer

const slot_scene = preload('res://ui/character_sheet/slots/DetailCardSlot.tscn')

export(Array, Resource) var card_pool = [] setget _set_card_pool
var context = null setget _set_context, _get_context

func _set_context(new_context) -> void:
	context = new_context
	refresh()

func _get_context():
	return context

func _set_card_pool(new_card_pool) -> void:
	card_pool = new_card_pool
	refresh()

func refresh() -> void:
	if has_node('Container'):
		var container = $Container
		if $Container.get_child_count() > card_pool.size():
			var children: Array = container.get_children()
			var num =  children.size() - card_pool.size()
			while num > 0:
				var child = children.pop_back()
				container.remove_child(child)
				child.queue_free()
				num -= 1
		else:
			var num =  card_pool.size() - container.get_child_count()
			while num > 0:
				var child = slot_scene.instance()
				container.add_child(child)
				num -= 1
		var children = container.get_children()
		for i in range(card_pool.size()):
			children[i].card = card_pool[i]
			children[i].context = context
