class_name BarnActionConductor
extends Node

static var barn_action_classes: Array[GDScript] = [
	BreedGoatBarnAction,
]

@export var goat_breeder: GoatBreeder

var _barn_actions: Array[BarnAction] = []


func add_goats(goats: Array[Goat]) -> void:
	var data := {"goats": goats}

	for barn_action_class in barn_action_classes:
		if not barn_action_class.is_applicable(data):
			continue

		var barn_action: BarnAction = barn_action_class.new(self, data)
		_barn_actions.append(barn_action)
		return

	print("No applicable barn action found for the given goats.")

	for goat in goats:
		goat.state_machine.transition_to_next_state(GoatState.IDLE)


func activate_barn_actions() -> void:
	for barn_action in _barn_actions:
		await barn_action.activate()
		print("Activated barn action: ", barn_action)

	_barn_actions.clear()


func cancel_barn_actions() -> void:
	for barn_action in _barn_actions:
		barn_action.cancel()
		print("Cancelled barn action: ", barn_action)

	_barn_actions.clear()
