class_name BarnDoor
extends Area2D

@export var _conductor: BarnActionConductor

var _goats_to_bundles: Dictionary[Goat, GoatBundle] = {}

@onready var _animation_player: AnimationPlayer = %AnimationPlayer


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	var goats: Array[Goat] = caller.empty_goats()

	if goats.is_empty():
		_go_to_sleep(caller)
		return

	var bundle := GoatBundle.new(self, goats)

	for goat in goats:
		assert(not goat in _goats_to_bundles, "Goat already in a bundle: " + goat.name)
		_goats_to_bundles[goat] = bundle

	bundle.complete.connect(_bundle_complete.bind(bundle))


func add_goat(goat: Goat) -> void:
	if not goat is Goat:
		print("BarnDoor can only accept Goat instances.")
		return

	assert(goat in _goats_to_bundles, "Goat not in a bundle: " + goat.name)

	goat.state_machine.transition_to_next_state(GoatState.HIDDEN)
	_goats_to_bundles[goat].add_goat(goat)
	_goats_to_bundles.erase(goat)


func _bundle_complete(bundle: GoatBundle) -> void:
	_conductor.add_goats(bundle.get_goats())
	bundle.complete.disconnect(_bundle_complete)


func _go_to_sleep(farmer: Farmer) -> void:
	farmer.visible = false

	_animation_player.play("barn_sleep")

	await _animation_player.animation_finished

	_animation_player.play("barn_shake")

	await _conductor.activate_barn_actions()

	_animation_player.stop()

	_animation_player.play_backwards("barn_sleep")

	await _animation_player.animation_finished

	farmer.visible = true


class GoatBundle extends RefCounted:
	signal complete

	var _goats: Dictionary[Goat, bool] = {}

	func _init(door: BarnDoor, goats: Array[Goat]) -> void:
		for goat in goats:
			_goats[goat] = false
			goat.state_machine.transition_to_next_state(GoatState.FOLLOW, {
				"target": door,
			})


	func add_goat(goat: Goat) -> void:
		if not goat in _goats:
			print("Goat not part of this bundle: ", goat.name)
			return

		_goats[goat] = true
		goat.state_machine.transition_to_next_state(GoatState.HIDDEN)
		print("Added goat to bundle: ", goat.name)

		if is_complete():
			complete.emit()


	func is_complete() -> bool:
		for goat in _goats:
			if not _goats[goat]:
				return false

		return true


	func get_goats() -> Array[Goat]:
		return _goats.keys()
