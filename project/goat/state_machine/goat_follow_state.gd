class_name GoatFollowState
extends GoatState

const FOLLOW_DISTANCE := 128.0

var target: Node2D


func enter(_previous_state_path: String, _data := {}) -> void:
	if _data.has("target"):
		target = _data.target
	else:
		printerr("No target provided to GoatFollowState.")
		finished.emit(IDLE)
		return

	goat.velocity = Vector2.ZERO
	# goat.animation_player.play("follow")

	if not target is BarnDoor:
		return

	var overlap := goat.hit_box.get_overlapping_areas()

	if overlap.is_empty():
		return

	for area in overlap:
		if area != target:
			continue

		goat.state_machine.transition_to_next_state(GoatState.ENTER_DOOR, {"door": area})
		return


func update(_delta: float) -> void:
	if goat.position.distance_to(target.position) <= FOLLOW_DISTANCE:
		goat.velocity = Vector2.ZERO
		return

	goat.velocity = (target.position - goat.position).normalized() * goat.speed


func on_hit_box_area_entered(area: Area2D) -> void:
	if area is BarnDoor:
		finished.emit(ENTER_DOOR, {"door": area})
