tool
extends Control
class_name CharacterSheetAwareControl

var sheet: CharacterSheetConcept = null setget _set_sheet

func _set_sheet(new_sheet: CharacterSheetConcept) -> void:
	print('sheet ', new_sheet)
	if sheet != null:
		sheet.disconnect('changed', self, '_on_sheet_changed')
	sheet = new_sheet
	if sheet != null:
		sheet.connect('changed', self, '_on_sheet_changed')
		_on_sheet_changed()

func _on_sheet_changed() -> void:
	pass
