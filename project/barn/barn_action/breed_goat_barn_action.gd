class_name BreedGoatBarnAction
extends BarnAction


var _goat_a: Goat
var _goat_b: Goat


func _init(barn_action_conductor: BarnActionConductor, data: Dictionary = {}) -> void:
	super._init(barn_action_conductor, data)

	assert(data.has("goats"), "BreedGoatBarnAction requires 'goats' in data.")

	_goat_a = data.goats[0]
	_goat_b = data.goats[1]

	if conductor.barn.use_power():
		is_instantaneous = true
		conductor.barn.use_power()


func activate() -> void:
	conductor.barn.start_shaking()
	await conductor.goat_breeder.breed(_goat_a, _goat_b)
	conductor.barn.stop_shaking()

	_goat_a.state_machine.transition_to_next_state(GoatState.IDLE)
	_goat_b.state_machine.transition_to_next_state(GoatState.IDLE)


func cancel() -> void:
	# If breeding is cancelled, we can just return the goats to idle state.
	_goat_a.state_machine.transition_to_next_state(GoatState.IDLE)
	_goat_b.state_machine.transition_to_next_state(GoatState.IDLE)


static func is_applicable(data: Dictionary = {}) -> bool:
	if not data.has("goats"):
		return false

	return data.goats.size() == 2
