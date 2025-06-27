class_name BarnDoor
extends StaticBody2D

@export var _goat_breeder: GoatBreeder

var _goats: Array[Goat] = []
var _summoned_goats: Array[Goat] = []


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	var goats_entering_barn: Array[Goat] = caller.empty_goats()

	if goats_entering_barn.is_empty():
		_go_to_sleep()
		return

	_summon_goats(goats_entering_barn)


func add_goat(goat: Goat) -> void:
	assert(goat in _summoned_goats, "Goat must be summoned before adding to barn door.")

	_goats.append(goat)
	_summoned_goats.erase(goat)
	print("Goat added to barn door: ", goat.name)

	if not _summoned_goats.is_empty():
		return

	if _goats.size() == 1:
		_sacrifice(_goats[0])
	elif _goats.size() == 2:
		_breed(_goats[0], _goats[1])
	else:
		print("Too many goats in barn door, cannot process.")

	_goats = []
	_summoned_goats = []


func _summon_goats(goats: Array[Goat]) -> void:
	if goats.size() > 2:
		print("Too many goats to summon at once, only two can be summoned.")
		return

	for goat in goats:
		if not goat in _summoned_goats:
			_summoned_goats.append(goat)
			goat.state_machine.transition_to_next_state(GoatState.FOLLOW, {"target": self})
			print("Summoned goat: ", goat.name)


func _breed(goat1: Goat, goat2: Goat) -> void:
	await _goat_breeder._breed(goat1, goat2)

	goat1.state_machine.transition_to_next_state(GoatState.IDLE)
	goat2.state_machine.transition_to_next_state(GoatState.IDLE)


func _sacrifice(goat: Goat) -> void:
	# TODO: Implement sacrifice logic
	await get_tree().create_timer(1.0).timeout

	goat.state_machine.transition_to_next_state(GoatState.IDLE)


func _go_to_sleep() -> void:
	pass
