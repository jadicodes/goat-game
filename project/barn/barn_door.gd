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
		_conductor.add_goats([])
		return

	var bundle := GoatBundle.new(self, goats)

	var open_doors := _goats_to_bundles.size() == 0

	for goat in goats:
		assert(not goat in _goats_to_bundles, "Goat already in a bundle: " + goat.name)
		_goats_to_bundles[goat] = bundle

	bundle.complete.connect(_bundle_complete.bind(bundle))

	if open_doors:
		await open()


func add_goat(goat: Goat) -> void:
	if not goat is Goat:
		print("BarnDoor can only accept Goat instances.")
		return

	assert(goat in _goats_to_bundles, "Goat not in a bundle: " + goat.name)

	goat.state_machine.transition_to_next_state(GoatState.HIDDEN)
	_goats_to_bundles[goat].add_goat(goat)
	_goats_to_bundles.erase(goat)

	if _goats_to_bundles.is_empty():
		await close()


func open() -> void:
	_animation_player.play("door_open")
	await _animation_player.animation_finished


func close() -> void:
	_animation_player.play_backwards("door_open")
	await _animation_player.animation_finished


func _bundle_complete(bundle: GoatBundle) -> void:
	_conductor.add_goats(bundle.get_goats())
	bundle.complete.disconnect(_bundle_complete)


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


func hover() -> void:
	%LeftDoor.material.set_shader_parameter("enabled", true)
	%RightDoor.material.set_shader_parameter("enabled", true)


func stop_hover() -> void:
	%LeftDoor.material.set_shader_parameter("enabled", false)
	%RightDoor.material.set_shader_parameter("enabled", false)
