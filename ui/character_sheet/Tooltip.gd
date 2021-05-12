extends PanelContainer

export(String) var label = '' setget _set_label


func _set_label(new_label: String) -> void:
	label = new_label
	$Label.text = label

func _ready() -> void:
	set_as_toplevel(true)
