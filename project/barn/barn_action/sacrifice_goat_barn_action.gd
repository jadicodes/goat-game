class_name SacrificeGoatBarnAction
extends BarnAction

var _goat: Goat


func _init(barn_action_conductor: BarnActionConductor, data: Dictionary = {}) -> void:
	super._init(barn_action_conductor, data)

	assert(data.has("goats"), "BreedGoatBarnAction requires 'goats' in data.")

	_goat = data.goats[0]


func activate() -> void:
	# Kill goat
	# Add 1 goat soul

	_goat.state_machine.transition_to_next_state(GoatState.IDLE)


static func is_applicable(data: Dictionary = {}) -> bool:
	if not data.has("goats"):
		return false

	return data.goats.size() == 2
