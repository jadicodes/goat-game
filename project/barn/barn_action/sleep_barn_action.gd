class_name SleepBarnAction
extends BarnAction


func _init(barn_action_conductor: BarnActionConductor, data: Dictionary = {}) -> void:
	super._init(barn_action_conductor, data)

	is_instantaneous = true


func activate() -> void:
	await conductor.barn.go_to_sleep()


static func is_applicable(data: Dictionary = {}) -> bool:
	return not data.has("goats") or data.goats.size() == 0
