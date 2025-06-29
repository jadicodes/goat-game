class_name SacrificeGoatBarnAction
extends BarnAction

var _goat: Goat


func _init(barn_action_conductor: BarnActionConductor, data: Dictionary = {}) -> void:
	super._init(barn_action_conductor, data)

	is_instantaneous = true

	assert(data.has("goats"), "SacrificeGoatBarnAction requires 'goats' in data.")

	_goat = data.goats[0]


func activate() -> void:
	_goat.queue_free()
	await conductor.barn.sacrifice()

	# TODO: Add goat soul


static func is_applicable(data: Dictionary = {}) -> bool:
	if not data.has("goats"):
		return false

	return data.goats.size() == 1
