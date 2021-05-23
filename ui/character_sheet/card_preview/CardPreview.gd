extends NinePatchRect

const CARD_ICON_NONE = preload('res://assets/sprites/card_icon_none.png')

var context = null setget _set_context
var prev_affinity = 0

func _set_context(new_context) -> void:
	unsubscribe()
	context = new_context
	subscribe()

func subscribe() -> void:
	if context != null:
		context.connect('hovered_card', self, '_on_hovered_card_changed')

func unsubscribe() -> void:
	if context != null:
		context.disconnect('hovered_card', self, '_on_hovered_card_changed')

func _on_hovered_card_changed(card: CardConcept) -> void:
	set_preview(card) if card != null else unset_preview()

func _ready() -> void:
	subscribe()

func set_preview(card: CardConcept) -> void:
	$CardNameContainer/Label.text = card.name
	$IconContainer/Icon.texture = card.icon
	$RarityAndType/Label.text = CommonConcept.Formatter.format_card_type(card.type)
	update_affinity(card.affinity)

func unset_preview() -> void:
	$CardNameContainer/Label.text = ''
	$IconContainer/Icon.texture = CARD_ICON_NONE
	$RarityAndType/Label.text = ''
	update_affinity(0)

func update_affinity(card_affinity: int):
	var index = 0
	var icons = $Affinity.get_children()
	for icon in icons:
		var affinity = CommonConcept.AFFINITIES[index]
		index += 1
		if (affinity & card_affinity) != 0 && (affinity & prev_affinity) == 0:
			icon.fade_in()
		if (affinity & card_affinity) == 0 && (affinity & prev_affinity) != 0:
			icon.fade_out()
	prev_affinity = card_affinity
