extends Resource
class_name PlayerConcept

export(String) var username
export(Dictionary) var characters
export(Dictionary) var cards

func _init(
	username: String,
	characters: Dictionary,
	cards: Dictionary
) -> void:
	self.username = username
	self.characters = characters
	self.cards = cards
