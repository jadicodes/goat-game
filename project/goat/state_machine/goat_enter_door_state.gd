class_name GoatEnterDoorState
extends GoatState

var door: BarnDoor


func enter(_previous_state_path: String, _data := {}) -> void:
	if _data.has("door"):
		door = _data.door
	else:
		printerr("No door provided to GoatEnterDoorState.")
		finished.emit(IDLE)
		return

	door.add_goat(goat)

	goat.velocity = Vector2.ZERO
	goat.visible = false
	goat.collision_shape.disabled = true


func exit() -> void:
	goat.visible = true
	goat.collision_shape.disabled = false
