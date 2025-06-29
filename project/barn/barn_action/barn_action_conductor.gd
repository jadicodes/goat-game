class_name BarnActionConductor
extends Node

static var barn_action_classes: Array[GDScript] = [
	SleepBarnAction,
	SacrificeGoatBarnAction,
	BreedGoatBarnAction,
]

@export var goat_breeder: GoatBreeder

var _barn_actions: Array[BarnAction] = []

@onready var barn: Barn = get_parent()


func add_goats(goats: Array[Goat]) -> void:
	var data := {"goats": goats}

	for barn_action_class in barn_action_classes:
		if not barn_action_class.is_applicable(data):
			continue

		await _add_action(barn_action_class.new(self, data))
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


func _add_action(barn_action: BarnAction) -> void:
	if barn_action.is_instantaneous:
		print("Barn action is instantaneous, activating immediately.")
		await barn_action.activate()
		return

	_barn_actions.append(barn_action)
	print("Added barn action: ", barn_action)
