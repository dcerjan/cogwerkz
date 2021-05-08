extends CharacterSheetAwareControl

onready var grid = $GridContainer

var slots

func _on_sheet_changed() -> void:
	if sheet == null:
		pass
