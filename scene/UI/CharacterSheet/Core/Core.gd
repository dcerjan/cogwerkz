extends CharacterSheetAwareControl

onready var race = $'Race Slot'
onready var clazz = $'Class Slot'

func _on_sheet_changed() -> void:
	if sheet == null:
		race.disable()
		clazz.disable()
	else:
		race.enable()
		if sheet.race_card != null:
			clazz.enable()
		else:
			clazz.disable()
