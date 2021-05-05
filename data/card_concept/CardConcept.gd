extends Resource
class_name CardConcept

export(String) var name = 'Unnamed Card'

# because https://github.com/godotengine/godot/issues/14681
# enums can't be referenced in export statements from other files,
# literally copy-pasta it here
enum Rarity {
	Common   = 0b0001
	Uncommon = 0b0010
	Rare     = 0b0100
	Mythic   = 0b1000
}
export(Rarity) var rarity = CommonConcept.Rarity.Common
